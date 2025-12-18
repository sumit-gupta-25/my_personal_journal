import 'dart:io' show File;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_personal_journal/service/database.dart';
import 'package:my_personal_journal/widgets/imagepicker.dart';
import 'package:my_personal_journal/widgets/navigatordrawer.dart' as custom;
import 'package:random_string/random_string.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  File? _image;
  Uint8List? _webImage;
  final TextEditingController _textController = TextEditingController();

  void _onImagePicked(File? file, Uint8List? webImage) {
    setState(() {
      if (kIsWeb) {
        _webImage = webImage;
      } else {
        _image = file;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      appBar: AppBar(
        title: const Text('Personal Journal'),
        centerTitle: true,
        foregroundColor: const Color(0xFFF5F5DC),
        backgroundColor: Colors.brown,
      ),
      drawer: const custom.NavigationDrawer(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TITLE TEXT
                Text(
                  '"Let Your Diary Carry\nWhat Burdens You..."',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.brown,
                  ),
                ),

                const SizedBox(height: 30),

                // TEXT INPUT
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/textbg.jpeg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    maxLength: 5000,
                    controller: _textController,
                    maxLines: 14,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Enter your thoughts...",
                      hintStyle: const TextStyle(color: Colors.white70),
                    ),
                    buildCounter: (
                      context, {
                      required currentLength,
                      required maxLength,
                      required isFocused,
                    }) {
                      return Text(
                        '$currentLength / $maxLength',
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

                // IMAGE SECTION
                Column(
                  children: [
                    (kIsWeb ? _webImage != null : _image != null)
                        ? const Text(
                            "Photo uploaded successfully!",
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          )
                        : const Text(
                            "No photo uploaded yet.",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        ImagePickerLogic.openDialog(context, _onImagePicked);
                      },
                      style: _buttonStyle(),
                      icon: const Icon(Icons.upload, color: Color(0xFFF5F5DC)),
                      label: const Text(
                        'Upload Image',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFF5F5DC),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, 'mydiary'),
                        style: _buttonStyle(),
                        icon: const Icon(Icons.my_library_books,
                            color: Color(0xFFF5F5DC)),
                        label: const Text(
                          'My Diary',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFF5F5DC),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _onSavePressed,
                        style: _buttonStyle(),
                        icon: const Icon(Icons.backup_outlined,
                            color: Color(0xFFF5F5DC)),
                        label: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFF5F5DC),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SAVE FUNCTION
  Future<void> _onSavePressed() async {
    if (_textController.text.isEmpty ||
        (!kIsWeb && _image == null) ||
        (kIsWeb && _webImage == null)) {
      Fluttertoast.showToast(
        msg: "Please enter content and upload an image.",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String journalId = randomAlphaNumeric(10);
      String formattedDate =
          "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";

      Uint8List imageBytes = kIsWeb ? _webImage! : await _image!.readAsBytes();

      Map<String, dynamic> journalMap = {
        "Content": _textController.text,
        "JournalId": journalId,
        "ImageBytes": imageBytes,
        "Timestamp": FieldValue.serverTimestamp(),
        "date": formattedDate,
      };

      await DatabaseMethods().addJournal(journalMap, userId, null);

      Navigator.of(context).pop();

      Fluttertoast.showToast(
        msg: "Journal saved successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (e) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: "Error: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.brown,
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

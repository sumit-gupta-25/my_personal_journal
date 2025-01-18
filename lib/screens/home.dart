import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_journal/service/database.dart';
import 'package:my_personal_journal/widgets/navigatordrawer.dart' as custom;
import 'package:my_personal_journal/widgets/imagepicker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  MyHomeState createState() => MyHomeState();
}

class MyHomeState extends State<MyHome> {
  File? _image;

  void _onImagePicked(File? image) {
    setState(() {
      _image = image;
    });
  }

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F5DC),
        appBar: AppBar(
          title: Text('Personal Journal'),
          centerTitle: true,
          foregroundColor: Color(0xFFF5F5DC),
          backgroundColor: Colors.brown,
        ),
        drawer: const custom.NavigationDrawer(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 60, top: 20, right: 35),
              child: Text(
                '"Let Your Diary Carry\nWhat Burdens You..."',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.brown,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 120, right: 10),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/textbg.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: 500,
                      width: 350,
                      child: TextField(
                        maxLength: 5000,
                        onChanged: (value) {
                          setState(() {});
                        },
                        buildCounter: (context,
                            {required int currentLength,
                            required bool isFocused,
                            required int? maxLength}) {
                          return Text(
                            '$currentLength / $maxLength',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        },
                        controller: _textController,
                        maxLines: 16,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Enter Your thoughts",
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 630, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _image != null
                        ? Text(
                            'Photo uploaded successfully!',
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          )
                        : Text(
                            'No photo uploaded yet.',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        ImagePickerLogic.openDialog(context, _onImagePicked);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(
                        Icons.upload,
                        color: Color(0xFFF5F5DC),
                      ),
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
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, 'mydiary');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(
                        Icons.my_library_books,
                        color: Color(0xFFF5F5DC),
                      ),
                      label: const Text(
                        'My Diary',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFF5F5DC),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (_image != null && _textController.text.isNotEmpty) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(child: CircularProgressIndicator());
                            },
                          );

                          try {
                            // Convert image to bytes
                            final imageBytes = await _image!.readAsBytes();

                            String userId =
                                FirebaseAuth.instance.currentUser!.uid;

                            // Create a unique ID for the journal entry
                            String journalId = randomAlphaNumeric(10);

                            // Format the current date
                            String formattedDate =
                                "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";

                            // Map to store journal details
                            Map<String, dynamic> journalMap = {
                              "Content": _textController.text,
                              "JournalId": journalId,
                              "ImageBytes": imageBytes,
                              "Timestamp": FieldValue.serverTimestamp(),
                              "date": formattedDate,
                            };

                            // Save to Firestore using DatabaseMethods
                            await DatabaseMethods()
                                .addJournal(journalMap, userId, null);

                            // To close the loading dialog and Succesful toast message
                            Navigator.of(context).pop();

                            Fluttertoast.showToast(
                              msg: "Journal saved successfully!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } catch (e) {
                            // To close the loading dialog and Error toast message
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                              msg: "Error: ${e.toString()}",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please enter content and upload an image.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(
                        Icons.backup_outlined,
                        color: Color(0xFFF5F5DC),
                      ),
                      label: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFF5F5DC),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:my_personal_journal/widgets/navigatordrawer.dart' as custom;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  File? _image;
  final picker = ImagePicker();
  bool _isFavorite = false;
  final TextEditingController _textController = TextEditingController();

  Future openDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) {
          File? dialogImage = _image; // Local reference for dialog state
          return StatefulBuilder(
            builder: (context, setStateDialog) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Container(
                width: 300,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/imagebg.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.only(left: 30, top: 50, right: 30),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 80,
                        );
                        if (pickedFile != null) {
                          setState(() {
                            _image = File(pickedFile.path); // Update global
                          });
                          setStateDialog(() {
                            dialogImage =
                                File(pickedFile.path); // Update dialog
                          });
                        } else {
                          print('No image picked');
                        }
                      },
                      child: Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        child: dialogImage != null
                            ? Image.file(
                                dialogImage!.absolute,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Upload Image",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Buttons at the bottom
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Cancel button
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
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
                            Icons.cancel_outlined,
                            color: Color(0xFFF5F5DC),
                          ),
                          label: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFF5F5DC),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Submit button
                        ElevatedButton.icon(
                          onPressed: () {
                            // You can handle the submit action here
                            // For example, save the image or trigger further actions
                            Navigator.of(context).pop(); // Close the dialog
                            print('Image submitted: ${dialogImage?.path}');
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
                            'Upload',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFF5F5DC),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // widget.imgUrl = null;
      } else {
        print('No image pucked');
      }
    });
  }

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
                              color: Colors
                                  .white, // Set the counter color to white
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
                    Positioned(
                      bottom: -2,
                      left: 15,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _isFavorite =
                                !_isFavorite; // Toggle favorite status
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: _isFavorite
                              ? Colors.red
                              : Colors.grey, // Change color
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
                    ElevatedButton.icon(
                      onPressed: () {
                        openDialog(context);
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
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
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
                        'Backup',
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
                padding:
                    const EdgeInsets.only(bottom: 20), // Add padding if needed
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
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, 'favourite');
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
                        Icons.favorite,
                        color: Color(0xFFF5F5DC),
                      ),
                      label: const Text(
                        'Favourites',
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
          ],
        ));
  }
}

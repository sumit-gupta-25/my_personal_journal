import 'dart:io' show File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerLogic {
  static final picker = ImagePicker();

  static Future<void> openDialog(
    BuildContext context,
    Function(File? file, Uint8List? webImage) onImagePicked,
  ) async {
    File? previewFile;
    Uint8List? previewWeb;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              content: Container(
                width: 320,
                height: 420,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/imagebg.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // IMAGE PICK AREA
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 80,
                        );

                        if (pickedFile != null) {
                          if (kIsWeb) {
                            final bytes = await pickedFile.readAsBytes();
                            setStateDialog(() => previewWeb = bytes);
                            onImagePicked(null, bytes);
                          } else {
                            final file = File(pickedFile.path);
                            setStateDialog(() => previewFile = file);
                            onImagePicked(file, null);
                          }
                        }
                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white),
                        ),
                        child: previewWeb != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(previewWeb!,
                                    fit: BoxFit.cover),
                              )
                            : previewFile != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(previewFile!,
                                        fit: BoxFit.cover),
                                  )
                                : const Center(
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Text(
                      "Upload Image",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // CANCEL
                        ElevatedButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown.shade600,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.cancel_outlined,
                              color: Color(0xFFF5F5DC)),
                          label: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFFF5F5DC),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // CONFIRM UPLOAD
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.upload,
                              color: Color(0xFFF5F5DC)),
                          label: const Text(
                            'Upload',
                            style: TextStyle(
                              color: Color(0xFFF5F5DC),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addJournal(
      Map<String, dynamic> journalMap, String id, Uint8List? imageBytes) async {
    journalMap['Date'] = FieldValue.serverTimestamp();

    if (imageBytes != null) {
      journalMap['ImageBytes'] = imageBytes;
    }

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .set(journalMap);
  }
}

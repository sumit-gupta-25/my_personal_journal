import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addJournal(
    Map<String, dynamic> journalMap,
    String userId,
    Uint8List? imageBytes,
  ) async {
    // Make sure the userId is included in the document
    journalMap['userId'] = userId;

    if (imageBytes != null) {
      journalMap['ImageBytes'] = imageBytes;
    }

    String formattedDate = journalMap['date'];

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection("journals")
        .doc(formattedDate)
        .set(journalMap);
  }

  Future<void> fetchJournalEntries(String userId, String selectedDate) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("journals")
          .where("date", isEqualTo: selectedDate)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          print("Journal Entry: ${doc.data()}");
        }
      } else {
        print("No entry found for the selected date.");
      }
    } catch (e) {
      print("Error fetching entries: $e");
    }
  }
}

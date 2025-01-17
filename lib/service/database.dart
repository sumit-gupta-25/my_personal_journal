import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addJournal(Map<String, dynamic> journalMap, String userId,
      Uint8List? imageBytes) async {
    if (imageBytes != null) {
      journalMap['ImageBytes'] = imageBytes;
    }

    String formattedDate = journalMap['date']; // Example: "2025-01-01"

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection("journals") // Subcollection (journal entries)
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

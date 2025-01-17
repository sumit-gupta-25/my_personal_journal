import 'dart:typed_data'; // Import for Uint8List
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyJournalScreen extends StatelessWidget {
  final DateTime selectedDate;
  final String userId; // User ID passed as a parameter

  const MyJournalScreen({
    super.key,
    required this.selectedDate,
    required this.userId,
  });

  Future<Map<String, dynamic>?> _fetchJournalEntry() async {
    String formattedDate =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

    try {
      // Firestore path: Users -> userId -> journals -> formattedDate
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('journals')
          .doc(formattedDate)
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error fetching journal entry: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        title: const Text('My Journal Entry'),
        centerTitle: true,
        foregroundColor: Color(0xFFF5F5DC),
        backgroundColor: Colors.brown,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchJournalEntry(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No entry found for this date.'));
          } else {
            final data = snapshot.data!;
            final String content = data['Content'] ?? 'No content available';

            // Convert List<dynamic> to Uint8List
            final List<dynamic>? imageList =
                data['ImageBytes'] as List<dynamic>?;
            final Uint8List? imageBytes = imageList != null
                ? Uint8List.fromList(imageList.cast<int>())
                : null;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(left: 10, top: 10, right: 10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/textbg.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              margin: EdgeInsets.only(left: 20, right: 20),
                              height: 500,
                              width: 370,
                              child: Text(content,
                                  style: TextStyle(
                                    color: Color(0xFFF5F5DC),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          ],
                        ),
                      )),
                  const SizedBox(height: 20.0),
                  imageBytes != null
                      ? Image.memory(
                          imageBytes,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: 200.0,
                        )
                      : const Text('No image available for this entry.'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

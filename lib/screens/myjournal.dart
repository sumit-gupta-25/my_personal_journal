import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../service/database.dart';
import 'package:my_personal_journal/screens/edit_journal_screen.dart';

class MyJournalScreen extends StatelessWidget {
  final DateTime selectedDate;
  final String userId;

  const MyJournalScreen({
    super.key,
    required this.selectedDate,
    required this.userId,
  });

  String get formattedDate =>
      "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

  Future<Map<String, dynamic>?> _fetchJournalEntry() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('journals')
          .doc(formattedDate)
          .get();

      return doc.exists ? doc.data() as Map<String, dynamic> : null;
    } catch (e) {
      throw Exception("Error fetching journal entry: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
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
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data;

          return Column(
            children: [
              Expanded(
                child: data == null
                    ? const Center(
                        child: Text(
                          'No entry found for this date.',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : _buildJournalContent(data),
              ),

              /// ======================
              /// BUTTON SECTION
              /// ======================
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: data == null
                    ? ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> newEntry = {
                            "date": formattedDate,
                            "Content": "Write something...",
                            "userId": userId,
                          };

                          await DatabaseMethods().addJournal(
                            newEntry,
                            userId,
                            null,
                          );

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text("Add Entry"),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // UPDATE BUTTON
                          ElevatedButton(
                              onPressed: () async {
                                final updated = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditJournalScreen(
                                      userId: userId,
                                      journalId: formattedDate,
                                      existingContent: data["Content"] ?? "",
                                    ),
                                  ),
                                );

                                // Refresh page after editing
                                if (updated == true) {
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown[400],
                              ),
                              child: const Text(
                                "Update",
                                style: TextStyle(color: Color(0xFFF5F5DC)),
                              )),

                          // DELETE BUTTON
                          ElevatedButton(
                              onPressed: () async {
                                await DatabaseMethods()
                                    .deleteJournal(userId, formattedDate);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown[400],
                              ),
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Color(0xFFF5F5DC)),
                              )),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// ==========================
  /// JOURNAL CONTENT WIDGET
  /// ==========================
  Widget _buildJournalContent(Map<String, dynamic> data) {
    final String content = data['Content'] ?? 'No content available';

    final List<dynamic>? imageList = data['ImageBytes'] as List<dynamic>?;
    final Uint8List? imageBytes =
        imageList != null ? Uint8List.fromList(imageList.cast<int>()) : null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/textbg.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                content,
                style: const TextStyle(
                  color: Color(0xFFF5F5DC),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            imageBytes != null
                ? Image.memory(
                    imageBytes,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 200,
                  )
                : const Text("No image available for this entry."),
          ],
        ),
      ),
    );
  }
}

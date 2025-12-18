import 'package:flutter/material.dart';
import '../service/database.dart';

class EditJournalScreen extends StatefulWidget {
  final String userId;
  final String journalId;
  final String existingContent;

  const EditJournalScreen({
    super.key,
    required this.userId,
    required this.journalId,
    required this.existingContent,
  });

  @override
  State<EditJournalScreen> createState() => _EditJournalScreenState();
}

class _EditJournalScreenState extends State<EditJournalScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.existingContent);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Entry"),
        backgroundColor: Colors.brown,
        foregroundColor: Color(0xFFF5F5DC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: "Edit your journal entry",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[400],
              ),
              onPressed: () async {
                await DatabaseMethods().updateJournal(
                  widget.userId,
                  widget.journalId,
                  {
                    "Content": _controller.text,
                  },
                );

                Navigator.pop(context, true); // Return success
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}

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
      backgroundColor: const Color(0xFFF5F5DC),
      appBar: AppBar(
        title: const Text("Edit Entry"),
        centerTitle: true,
        backgroundColor: Colors.brown,
        foregroundColor: const Color(0xFFF5F5DC),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/textbg.jpeg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                        color: Color(0xFFF5F5DC),
                        fontSize: 18,
                        height: 1.4,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Edit your journal entry...",
                        hintStyle: TextStyle(color: Color(0xFFF5F5DC)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      await DatabaseMethods().updateJournal(
                        widget.userId,
                        widget.journalId,
                        {
                          "Content": _controller.text,
                        },
                      );

                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Color(0xFFF5F5DC),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

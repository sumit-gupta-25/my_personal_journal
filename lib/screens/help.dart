import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I create a new journal entry?',
      'answer':
          'To create a new journal entry:\n1. Go to the home screen.\n2. Write your thoughts in the text box.\n3. Upload an image.\n4. Tap "Save" to store it in the cloud.',
    },
    {
      'question': 'How do I view my saved journal entries?',
      'answer':
          'Tap the "My Diary" button on the home screen.\nSelect a date to view your entry saved on that day.',
    },
    {
      'question': 'How do I upload an image?',
      'answer':
          'Tap the "Upload Image" button, select an image from your device, and it will attach to your journal entry.',
    },
    {
      'question': 'What happens if I lose my device?',
      'answer':
          'Your entries are stored in Firebase Cloud.\nLog in from any device to access them again.',
    },
    {
      'question': 'How is my data secured?',
      'answer':
          'Your entries are stored securely in Firestore and are only accessible through your authenticated account.',
    },
    {
      'question': 'How do I register?',
      'answer':
          'On the login screen, tap "Sign Up", enter your details, and create your account.',
    },
    {
      'question': 'How do I report a bug or suggest features?',
      'answer': 'Send your feedback to our support email mentioned below.',
    },
    {
      'question': 'Can I edit or delete a journal entry?',
      'answer':
          'Yes! You can update or delete entries from the “View Journal” screen.',
    },
  ];

  Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5DC),
      appBar: AppBar(
        title: const Text('Help & Support'),
        centerTitle: true,
        foregroundColor: const Color(0xFFF5F5DC),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Frequently Asked Questions',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.brown,
                  ),
                ),
                const SizedBox(height: 25),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: faqs.length,
                  itemBuilder: (context, index) {
                    final faq = faqs[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Q${index + 1}. ${faq['question']}",
                            style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            faq['answer']!,
                            style: const TextStyle(
                              color: Colors.brown,
                              fontSize: 16,
                              height: 1.4,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(color: Colors.brown, thickness: 1),
                const SizedBox(height: 20),
                const Text(
                  'Need More Help?',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'If you encounter any issues or have suggestions, feel free to contact our support team:',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Email: support@mypersonaljournalapp.com',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
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

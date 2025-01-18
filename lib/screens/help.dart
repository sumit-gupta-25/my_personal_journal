import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I create a new journal entry?',
      'answer':
          'To create a new journal entry, follow these steps:\n1. Navigate to the home screen.\n2. Use the text field to write your thoughts.\n3. Click on the "Upload Image" button to add a photo.\n4. Click on the "Save" button to save your entry to the cloud.',
    },
    {
      'question': 'How do I view my saved journal entries?',
      'answer':
          'Tap on the "My Diary" button at the bottom of the home screen.\nThis will navigate you to a screen where you can select the date and view your journal stored on the selected date.',
    },
    {
      'question': 'How do I upload an image to my journal entry?',
      'answer':
          'Tap the "Upload Image" button on the home screen.\nSelect an image from your gallery.\nThe selected image will be attached to your journal entry.',
    },
    {
      'question': 'What happens if I lose my device?',
      'answer':
          'Since your journal entries are backed up to the cloud, you can log in from any device to access your entries.',
    },
    {
      'question': 'How is my data secured?',
      'answer':
          'Your data is stored securely in Firebase Firestore and is only accessible to you through your authenticated account.',
    },
    {
      'question': 'How do I register for a new account?',
      'answer':
          'Tap the "Sign Up" button on the login screen.\nFill in your email and password details, then submit the form.\nYou will be registered and can use these credentials to log in.',
    },
    {
      'question': 'How do I report a bug or suggest a feature?',
      'answer':
          'You can report bugs or suggest new features by contacting the support email provided in the app.',
    },
    {
      'question': 'Can I edit or delete a journal entry after saving it?',
      'answer':
          'Currently, the app allows you to view journal entries, but editing or deleting them is not supported. Future updates may include this feature.',
    },
  ];

  Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        title: Text('Help & Support'),
        foregroundColor: Color(0xFFF5F5DC),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.brown,
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  final faq = faqs[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Q${index + 1}. ${faq['question']}',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 5),
                      Text(
                        faq['answer']!,
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),

              // Support Email
              Divider(color: Colors.brown),
              SizedBox(height: 10),
              Text(
                'Need More Help?',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'If you encounter any issues or have suggestions, feel free to reach out to our support team:',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Email: support@mypersonaljournalapp.com',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

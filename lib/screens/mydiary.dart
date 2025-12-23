import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_journal/screens/myjournal.dart';
import 'package:my_personal_journal/widgets/navigatordrawer.dart' as custom;

class MyDiary extends StatefulWidget {
  const MyDiary({super.key});

  @override
  MyDiaryState createState() => MyDiaryState();
}

class MyDiaryState extends State<MyDiary> {
  DateTime? selectedDate;

  // Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/mydiarybg.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawerScrimColor: Colors.black.withValues(alpha: 0.4),
        appBar: AppBar(
          title: const Text('My Diary'),
          centerTitle: true,
          foregroundColor: Color(0xFFF5F5DC),
          backgroundColor: Colors.brown,
        ),
        drawer: const custom.NavigationDrawer(),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 450,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedDate == null
                        ? 'No date selected!'
                        : 'Selected Date: ${selectedDate!.toLocal()}'
                            .split(' ')[0],
                    style: const TextStyle(
                      color: Color(0xFFF5F5DC),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // SELECT DATE BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _selectDate(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(
                        Icons.date_range_outlined,
                        color: Color(0xFFF5F5DC),
                      ),
                      label: const Text(
                        'Select Date',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFF5F5DC),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // VIEW JOURNAL BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: selectedDate == null
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyJournalScreen(
                                    selectedDate: selectedDate!,
                                    userId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                  ),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(
                        Icons.library_books_outlined,
                        color: Color(0xFFF5F5DC),
                      ),
                      label: const Text(
                        'View Journal',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFF5F5DC),
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
      ),
    );
  }
}

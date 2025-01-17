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

  //Date Picker
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
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/mydiarybg.jpeg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Diary'),
          centerTitle: true,
          foregroundColor: Color(0xFFF5F5DC),
          backgroundColor: Colors.brown,
        ),
        drawer: const custom.NavigationDrawer(),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  selectedDate == null
                      ? 'No date selected!'
                      : 'Selected Date: ${selectedDate!.toLocal()}'
                          .split(' ')[0],
                  style: TextStyle(
                    color: Color(0xFFF5F5DC),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                onPressed: selectedDate == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyJournalScreen(
                              selectedDate: selectedDate!,
                              userId: FirebaseAuth.instance.currentUser!.uid,
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
            ],
          ),
        ),
      ),
    );
  }
}

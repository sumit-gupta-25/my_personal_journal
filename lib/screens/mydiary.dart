import 'package:flutter/material.dart';
import 'package:my_personal_journal/widgets/navigatordrawer.dart' as custom;
import 'package:table_calendar/table_calendar.dart';

class MyDiary extends StatefulWidget {
  const MyDiary({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDiaryState createState() => _MyDiaryState();
}

class _MyDiaryState extends State<MyDiary> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/favouritebg.jpeg'), fit: BoxFit.cover),
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
            body: Stack(children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 20, right: 35),
                child: Text(
                  '"Let Your Diary Carry\nWhat Burdens You..."',
                  style: TextStyle(
                    color: Color(0xFFF5F5DC),
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.brown,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 575,
                  width: 350,
                  padding:
                      EdgeInsets.all(20), // Adjust padding for internal spacing
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/datebg1.jpeg'), // Background image
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                        BorderRadius.circular(15), // Optional rounded corners
                  ),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center contents vertically
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Center contents horizontally
                    children: [
                      Text(
                        'Select Date',
                        style: TextStyle(fontSize: 20, color: Colors.brown),
                      ),
                      SizedBox(
                          height: 10), // Spacing between title and calendar
                      TableCalendar(
                        firstDay: DateTime(2025),
                        lastDay: DateTime(2030),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay; // Update focused day
                          });
                          print(
                              'Date selected: ${selectedDay.day}-${selectedDay.month}-${selectedDay.year}');
                        },
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Colors.brown,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Color(0xFFF5F5DC),
                            shape: BoxShape.circle,
                          ),
                          selectedTextStyle: TextStyle(color: Colors.black),
                          weekendTextStyle: TextStyle(color: Colors.red),
                        ),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5DC),
                          ),
                          titleTextStyle: TextStyle(
                            color: Colors.brown,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ])));
  }
}

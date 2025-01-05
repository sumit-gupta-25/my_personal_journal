import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_journal/screens/login.dart';
import 'package:my_personal_journal/screens/register.dart';
import 'package:my_personal_journal/screens/home.dart';
import 'package:my_personal_journal/screens/mydiary.dart';
import 'package:my_personal_journal/screens/favourites.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHome(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'home': (context) => MyHome(),
      'mydiary': (context) => MyDiary(),
      'favourite': (context) => Favourite(),
    },
  ));
}

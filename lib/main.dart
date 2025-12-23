import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_personal_journal/screens/login.dart';
import 'package:my_personal_journal/screens/register.dart';
import 'package:my_personal_journal/screens/home.dart';
import 'package:my_personal_journal/screens/mydiary.dart';
import 'package:my_personal_journal/screens/help.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final auth = FirebaseAuth.instance;
  if (auth.currentUser == null) {
    await auth.signInAnonymously();
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'home': (context) => MyHome(),
      'mydiary': (context) => MyDiary(),
      'help': (context) => Help(),
    },
  ));
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_personal_journal/screens/login.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/settingbg.jpeg'),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildHeader(context),
                buildMenuItems(context),
              ],
            )),
      ));

  Widget buildHeader(BuildContext context) => Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        children: const [
          Image(
              image: AssetImage("assets/hand&quill.png"),
              width: 300,
              height: 300),
          Text(
            'Personal Journal',
            style: TextStyle(
              color: Color(0xFFF5F5DC),
              fontSize: 28,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFFF5F5DC),
            ),
          ),
        ],
      ));

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                color: Color(0xFFF5F5DC),
                size: 25,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Color(0xFFF5F5DC),
                  fontSize: 25,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'home');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.help_outline_outlined,
                color: Color(0xFFF5F5DC),
                size: 25,
              ),
              title: Text(
                'Help & Support',
                style: TextStyle(
                  color: Color(0xFFF5F5DC),
                  fontSize: 25,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'help');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                color: Color(0xFFF5F5DC),
                size: 25,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Color(0xFFF5F5DC),
                  fontSize: 25,
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyLogin()));
                });
              },
            ),
          ],
        ),
      );
}

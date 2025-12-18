import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_personal_journal/screens/login.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/settingbg.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildHeader(context),
            const Divider(
              color: Color(0xFFF5F5DC),
              thickness: 0.3,
              indent: 16,
              endIndent: 16,
            ),
            Expanded(child: _buildMenuItems(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 10,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: Image.asset(
              "assets/hand&quill.png",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Personal Journal',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFF5F5DC),
              fontSize: 24,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFFF5F5DC),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        _drawerItem(
          context,
          icon: Icons.home_outlined,
          label: "Home",
          route: "home",
        ),
        _drawerItem(
          context,
          icon: Icons.help_outline_outlined,
          label: "Help & Support",
          route: "help",
        ),
        _drawerItem(
          context,
          icon: Icons.logout_outlined,
          label: "Logout",
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MyLogin()),
              (route) => false,
            );
          },
        ),
      ],
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    String? route,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap ??
              () {
                Navigator.pushNamed(context, route!);
              },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFFF5F5DC), size: 26),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFFF5F5DC),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

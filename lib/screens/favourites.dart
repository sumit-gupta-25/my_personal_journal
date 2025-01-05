import 'package:flutter/material.dart';
import 'package:my_personal_journal/widgets/navigatordrawer.dart' as custom;

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/favouritebg.jpeg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
            appBar: AppBar(
              title: Text('Favourites'),
              centerTitle: true,
              foregroundColor: Color(0xFFF5F5DC),
              backgroundColor: Colors.brown,
            ),
            drawer: const custom.NavigationDrawer(),
            backgroundColor: Colors.transparent,
            body: Stack(children: [Container()])));
  }
}

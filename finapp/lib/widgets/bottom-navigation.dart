import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finapp/views/home.dart';
import 'package:finapp/views/new-entry.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.grey[850],
      color: Colors.grey[800],
      height: 55,
      items: <Widget>[
        Icon(Icons.home, size: 25),
        Icon(Icons.create_rounded, size: 25),
        Icon(Icons.history, size: 25),
        Icon(Icons.credit_card_outlined, size: 25),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewEntry(),
            ),
          );
        }
      },
    );
  }
}

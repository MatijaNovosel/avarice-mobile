import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize {
    return new Size.fromHeight(60.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: Colors.grey[850],
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textBaseline: TextBaseline.ideographic,
        children: [
          Text('Finapp',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 138, 0))),
          Container(
              margin: EdgeInsets.only(left: 3.0),
              child: Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text('by Matija Novosel',
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey[400])))),
          Spacer(),
          Container(
              margin: EdgeInsets.only(right: 15.0), child: Icon(Icons.logout))
        ],
      ),
    );
  }
}

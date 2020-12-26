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
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          Text(
            'Finapp',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = LinearGradient(
                  colors: <Color>[
                    Color.fromARGB(255, 255, 138, 0),
                    Color.fromARGB(255, 229, 46, 113)
                  ],
                ).createShader(
                  Rect.fromLTWH(40.0, 0.0, 80.0, 200.0),
                ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.0),
            child: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                'by Matija Novosel',
                style: TextStyle(fontSize: 13, color: Colors.grey[400]),
              ),
            ),
          )
        ],
      ),
    );
  }
}

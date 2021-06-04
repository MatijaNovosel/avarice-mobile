import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize {
    return new Size.fromHeight(60.0);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.grey[500],
        ), // set your color here
        onPressed: () {},
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          Text(
            'Finapp',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

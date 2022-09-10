import 'package:flutter/material.dart';

class _TagState extends State<TagWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.color,
      ),
      child: Center(
        child: Text(widget.text),
      ),
    );
  }
}

class TagWidget extends StatefulWidget {
  final String text;
  final Color color;

  const TagWidget({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  _TagState createState() => _TagState();
}

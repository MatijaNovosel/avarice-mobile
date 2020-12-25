import 'package:finapp/models/financial-change.dart';
import 'package:flutter/material.dart';

class _ChangeCardState extends State<ChangeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(widget.financialChange.description),
        ],
      ),
    );
  }
}

class ChangeCardWidget extends StatefulWidget {
  final FinancialChange financialChange;
  const ChangeCardWidget({Key key, this.financialChange}) : super(key: key);
  @override
  _ChangeCardState createState() => _ChangeCardState();
}
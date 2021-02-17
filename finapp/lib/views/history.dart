import 'package:finapp/controllers/form-submit-controller.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final FormSubmitController formSubmitController = FormSubmitController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
      ),
      child: Center(
        child: Text("History"),
      ), // Exp ExpenseForm(controller: formSubmitController),
    );
  }
}

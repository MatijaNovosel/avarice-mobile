import 'package:finapp/controllers/form-submit-controller.dart';
import 'package:flutter/material.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
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
        child: Text("Accounts"),
      ), // ExpenseForm(controller: formSubmitController),
    );
  }
}

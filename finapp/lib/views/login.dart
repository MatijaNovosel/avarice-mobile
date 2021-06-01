import 'package:finapp/controllers/formSubmitController.dart';
import 'package:finapp/widgets/forms/loginForm.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FormSubmitController formSubmitController = new FormSubmitController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoginForm(
            controller: formSubmitController,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: ElevatedButton(
              onPressed: () {
                formSubmitController.submit();
              },
              child: Text("Submit"),
            ),
          )
        ],
      ),
    );
  }
}

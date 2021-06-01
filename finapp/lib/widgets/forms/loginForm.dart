import 'package:finapp/controllers/formSubmitController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginForm extends StatefulWidget {
  final FormSubmitController controller;
  LoginForm({this.controller});

  @override
  _LoginFormState createState() => _LoginFormState(controller);
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _LoginFormState(FormSubmitController _controller) {
    _controller.submit = submit;
  }

  void submitForm() {
    if (_formKey.currentState.validate()) {
      var payload = {
        "password": _passwordController.text,
        "email": _emailController.text
      };

      print(payload);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: SpinKitFoldingCube(
                color: Colors.red,
                size: 65,
              ),
            ),
          );
        },
      );
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    } else {
      var snackBar = SnackBar(
        content: Text(
          'Invalid data supplied!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[800],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void submit() {
    submitForm();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: Icon(
                Icons.email_rounded,
                color: Colors.grey[350],
              ),
            ),
            title: TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field is required!';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350]),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350]),
                ),
                hintText: "Email",
                isDense: true,
                labelText: "Email",
                alignLabelWithHint: true,
                labelStyle: TextStyle(color: Colors.grey[350]),
              ),
            ),
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: Icon(
                Icons.lock,
                color: Colors.grey[350],
              ),
            ),
            title: TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field is required!';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350]),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[350]),
                ),
                hintText: "Password",
                isDense: true,
                labelText: "Password",
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: Colors.grey[350],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

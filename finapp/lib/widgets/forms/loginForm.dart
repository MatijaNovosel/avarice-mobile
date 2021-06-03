import 'package:finapp/controllers/formSubmitController.dart';
import 'package:finapp/main.dart';
import 'package:finapp/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _hidePassword = true;

  _LoginFormState(FormSubmitController _controller) {
    _controller.submit = submit;
  }

  void submitForm() {
    if (_formKey.currentState.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: SpinKitFoldingCube(
                color: Colors.white,
                size: 65,
              ),
            ),
          );
        },
      );
      Future.delayed(const Duration(seconds: 1), () async {
        Navigator.pop(context);
        var response = await login(
          _emailController.text,
          _passwordController.text,
        );
        if (response.result == true) {
          var snackBar = SnackBar(
            content: Text(
              "Successfully signed in!",
              style: new TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("bearerToken", response.token);

          Map<String, dynamic> decodedToken = Jwt.parseJwt(response.token);

          prefs.setString("username", decodedToken["unique_name"]);
          prefs.setString("email", _emailController.text);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (Route<dynamic> route) => false,
          );
        } else {
          var snackBar = SnackBar(
            content: Text(
              response.errors.join(", "),
              style: new TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red[900],
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
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
              obscureText: _hidePassword,
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

import 'package:finapp/controllers/formSubmitController.dart';
import 'package:finapp/main.dart';
import 'package:finapp/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FormSubmitController formSubmitController = new FormSubmitController();

  Future<String> _onLogin(LoginData data) async {
    var response = await login(
      data.name,
      data.password,
    );

    if (response.result == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("bearerToken", response.token);

      Map<String, dynamic> decodedToken = Jwt.parseJwt(response.token);

      prefs.setString("username", decodedToken["unique_name"]);
      prefs.setString("email", data.name);

      return null;
    } else {
      return response.errors.join(", ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        title: 'FinApp',
        onLogin: _onLogin,
        onSignup: (_) => Future(null),
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MainScreen(),
          ));
        },
        onRecoverPassword: (_) => Future(null),
        messages: LoginMessages(
          usernameHint: 'Email',
          passwordHint: 'Password',
          confirmPasswordHint: 'Confirm',
          loginButton: 'Log in',
          signupButton: 'Register',
          forgotPasswordButton: 'Forgot password',
          recoverPasswordButton: 'Recover password',
          goBackButton: 'Go back',
          confirmPasswordError: 'Password does not match',
          recoverPasswordDescription: 'Recover password',
          recoverPasswordSuccess: 'Password rescued successfully',
        ),
        theme: LoginTheme(
          titleStyle: TextStyle(
            letterSpacing: 6,
          ),
          bodyStyle: TextStyle(
            color: Colors.white,
          ),
          textFieldStyle: TextStyle(
            color: Colors.white,
          ),
          inputTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.black.withOpacity(.1),
          ),
        ),
      ),
    );
  }
}

library auth_service;

import 'package:dio/dio.dart';
import 'package:finapp/models/auth.dart';
import "../constants/apiConstants.dart";

Future<AuthResponse> login(String email, String password) async {
  var dio = new Dio();
  try {
    var response = await dio.post(
      "$apiUrl/auth/login",
      data: {
        "email": email,
        "password": password,
      },
    );
    return new AuthResponse(
      token: response.data["token"],
      result: response.data["result"],
      errors: response.data["errors"] != null
          ? response.data["errors"].cast<String>()
          : [],
    );
  } finally {
    dio.close();
  }
}

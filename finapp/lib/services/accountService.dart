library account_service;

import 'package:dio/dio.dart';
import 'package:finapp/models/account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../constants/apiConstants.dart";

Future<List<Account>> getLatestAccountValues() async {
  var dio = new Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");

  dio.options.headers["Authorization"] = "Bearer $token";

  try {
    List<Account> data = [];

    var response = await dio.get(
      "$apiUrl/account/latest-values",
      queryParameters: {
        "userId": userId,
      },
    );

    for (var account in response.data) {
      data.add(
        new Account(
          amount: account["amount"]
              .toDouble(), // Dynamic types may be binded to an int instead of a double ...
          description: account["description"],
          id: account["id"],
        ),
      );
    }

    return data;
  } finally {
    dio.close();
  }
}

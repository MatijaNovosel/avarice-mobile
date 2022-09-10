library account_service;

import 'package:dio/dio.dart';
import 'package:finapp/models/account/account.dart';
import 'package:finapp/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Account>> getLatestAccountValues() async {
  var dio = new Dio();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");
  dio.options.headers["Authorization"] = "Bearer $token";

  try {
    List<Account> data = [];

    var response = await dio.get(
      "${Config.API_URL}/account/latest-values",
    );

    for (var account in response.data) {
      data.add(new Account.fromJson(account));
    }

    return data;
  } finally {
    dio.close();
  }
}

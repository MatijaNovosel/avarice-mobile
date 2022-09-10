library transaction_service;

import 'package:dio/dio.dart';
import 'package:finapp/models/tag/tag.dart';
import 'package:finapp/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Tag>> getTags() async {
  var dio = new Dio();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");
  dio.options.headers["Authorization"] = "Bearer $token";

  try {
    List<Tag> data = [];
    var response = await dio.get("${Config.API_URL}/tag");

    for (var tag in response.data) {
      data.add(new Tag.fromJson(tag));
    }

    return data;
  } finally {
    dio.close();
  }
}

library transaction_service;

import 'package:dio/dio.dart';
import 'package:finapp/constants/apiConstants.dart';
import 'package:finapp/models/tag.dart';
import 'package:flutter_session/flutter_session.dart';

Future<List<Tag>> getTags() async {
  var dio = new Dio();
  var token = await FlutterSession().get("bearerToken");

  dio.options.headers["Authorization"] = "Bearer $token";

  try {
    List<Tag> data = [];

    var response = await dio.get(
      "$apiUrl/tag",
      queryParameters: {
        "userId": userId,
      },
    );

    for (var tag in response.data) {
      data.add(
        new Tag(
          description: tag["description"],
          id: tag["id"],
        ),
      );
    }

    return data;
  } finally {
    dio.close();
  }
}

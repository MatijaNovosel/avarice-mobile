library transaction_service;

import 'package:dio/dio.dart';
import 'package:finapp/constants/apiConstants.dart';
import 'package:finapp/models/tag.dart';
import 'package:flutter_session/flutter_session.dart';

import '../models/transaction.dart';

Future<List<Transaction>> getTransactions() async {
  var dio = new Dio();
  var token = await FlutterSession().get("bearerToken");

  dio.options.headers["Authorization"] = "Bearer $token";

  try {
    List<Transaction> data = [];

    var response = await dio.get(
      "$apiUrl/transaction",
      queryParameters: {
        "userId": userId,
        "skip": 0,
        "take": 25,
      },
    );

    for (var transaction in response.data) {
      data.add(
        new Transaction(
          amount: transaction["amount"]
              .toDouble(), // Dynamic types may be binded to an int instead of a double ...
          description: transaction["description"],
          id: transaction["id"],
          accountDescription: transaction["account"]["description"],
          createdAt: transaction["createdAt"],
          expense: transaction["expense"],
          tags: transaction["tags"]
              .map<Tag>(
                (x) => new Tag(
                  description: x["description"],
                  id: x["id"],
                ),
              )
              .toList(),
        ),
      );
    }

    return data;
  } finally {
    dio.close();
  }
}

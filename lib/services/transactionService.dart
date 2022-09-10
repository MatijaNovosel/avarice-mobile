library transaction_service;

import 'package:dio/dio.dart';
import 'package:finapp/constants/apiConstants.dart';
import 'package:finapp/models/tag/tag.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction.dart';

Future<List<Transaction>> getTransactions(int skip, int take) async {
  var dio = new Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");

  dio.options.headers["Authorization"] = "Bearer $token";

  try {
    List<Transaction> data = [];

    var response = await dio.get(
      "$apiUrl/transaction",
      queryParameters: {
        "skip": skip,
        "take": take,
      },
    );

    for (var transaction in response.data["results"]) {
      data.add(
        new Transaction(
          amount: transaction["amount"].toDouble(), // Dynamic types may be binded to an int instead of a double ...
          description: transaction["description"],
          id: transaction["id"],
          accountDescription: transaction["account"]["description"],
          createdAt: transaction["createdAt"],
          expense: transaction["expense"],
          tags: transaction["tags"].map<Tag>((tag) => new Tag.fromJson(tag)).toList(),
        ),
      );
    }

    return data;
  } finally {
    dio.close();
  }
}

Future addTransaction(NewTransaction payload) async {
  var dio = new Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");

  dio.options.headers["Authorization"] = "Bearer $token";

  try {
    await dio.post(
      "$apiUrl/transaction",
      data: {
        "amount": payload.amount,
        "description": payload.description,
        "accountId": payload.accountId,
        "createdAt": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(
          DateTime.now(),
        ),
        "expense": payload.expense,
        "tagIds": payload.tags,
      },
    );
  } catch (e) {
    print(e);
  } finally {
    dio.close();
  }
}

Future addTransfer(NewTransfer payload) async {
  var dio = new Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");

  dio.options.headers["Authorization"] = "Bearer $token";

  try {
    await dio.post(
      "$apiUrl/transaction/transfer",
      data: {
        "amount": payload.amount,
        "accountFromId": payload.accountFromId,
        "accountToId": payload.accountToId,
        "createdAt": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(
          DateTime.now(),
        ),
      },
    );
  } catch (e) {
    print(e);
  } finally {
    dio.close();
  }
}

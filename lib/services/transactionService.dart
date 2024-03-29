library transaction_service;

import 'package:dio/dio.dart';
import 'package:finapp/models/newTransaction/newTransaction.dart';
import 'package:finapp/models/newTransfer/newTransfer.dart';
import 'package:finapp/models/transaction/transaction.dart';
import 'package:finapp/utils/config.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Transaction>> getTransactions(int skip, int take) async {
  var dio = new Dio();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");
  dio.options.headers["Authorization"] = "Bearer $token";

  try {
    List<Transaction> data = [];

    var response = await dio.get(
      "${Config.API_URL}/transaction",
      queryParameters: {
        "skip": skip,
        "take": take,
      },
    );

    for (var transaction in response.data["results"]) {
      data.add(new Transaction.fromJson(transaction));
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
      "${Config.API_URL}/transaction",
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
      "${Config.API_URL}/transaction/transfer",
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

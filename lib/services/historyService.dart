import 'package:dio/dio.dart';
import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../constants/apiConstants.dart";

Future<RecentDepositsAndWithdrawals> getRecentDepositsAndWithdrawals() async {
  var dio = new Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");

  dio.options.headers["Authorization"] = "Bearer $token";

  try {
    var response = await dio.get(
      "$apiUrl/history/recent-deposits-and-withdrawals",
    );

    return RecentDepositsAndWithdrawals(
      deposits: response.data["deposits"].toDouble(),
      withdrawals: response.data["withdrawals"].toDouble(),
    );
  } finally {
    dio.close();
  }
}

Future<List<HistoryModel>> getTotalHistory() async {
  var dio = new Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");

  dio.options.headers["Authorization"] = "Bearer $token";

  List<HistoryModel> data = [];

  try {
    var response = await dio.get(
      "$apiUrl/history/total",
      queryParameters: {
        "from": DateTime.now().subtract(
          Duration(
            days: 30,
          ),
        ),
        "to": DateTime.now(),
      },
    );

    for (var history in response.data) {
      data.add(
        new HistoryModel(
          amount: history["amount"].toDouble(),
          createdAt: history["createdAt"],
        ),
      );
    }

    return data;
  } finally {
    dio.close();
  }
}

Future<List<HistoryModel>> getTotalHistoryForAccount(int accountId) async {
  var dio = new Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");

  dio.options.headers["Authorization"] = "Bearer $token";

  List<HistoryModel> data = [];

  try {
    var response = await dio.get(
      "$apiUrl/history/account/$accountId",
      queryParameters: {
        "from": DateTime.now().subtract(
          Duration(
            days: 30,
          ),
        ),
        "to": DateTime.now(),
      },
    );

    for (var history in response.data) {
      data.add(
        new HistoryModel(
          amount: history["amount"].toDouble(),
          createdAt: history["createdAt"],
        ),
      );
    }

    return data;
  } finally {
    dio.close();
  }
}

Future<List<TagPercentageModel>> getTagPercentages() async {
  var dio = new Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");

  dio.options.headers["Authorization"] = "Bearer $token";

  List<TagPercentageModel> data = [];

  try {
    var response = await dio.get(
      "$apiUrl/history/tag-percentages",
    );

    List<Color> colors = [];

    for (var tagPercentage in response.data) {
      Color randColor = randomColor();

      while (true) {
        if (colors.contains(randColor)) {
          randColor = randomColor();
        } else {
          colors.add(randColor);
          break;
        }
      }

      data.add(
        new TagPercentageModel(
          percentage: tagPercentage["percentage"].toDouble(),
          description: tagPercentage["description"],
          color: randColor,
        ),
      );
    }

    data.sort((a, b) => a.percentage.compareTo(b.percentage));

    return data.reversed.toList();
  } finally {
    dio.close();
  }
}

Future<List<SpendingByTagModel>> getSpendingByTag() async {
  var dio = new Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");

  dio.options.headers["Authorization"] = "Bearer $token";

  List<SpendingByTagModel> data = [];

  try {
    var response = await dio.get(
      "$apiUrl/history/spending-by-tag",
    );

    for (var spendingByTag in response.data) {
      data.add(
        new SpendingByTagModel(
          amount: spendingByTag["amount"].toDouble(),
          description: spendingByTag["description"],
        ),
      );
    }

    data.sort((a, b) => a.amount.compareTo(b.amount));

    return data.reversed.toList();
  } finally {
    dio.close();
  }
}

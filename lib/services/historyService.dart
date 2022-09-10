import 'package:dio/dio.dart';
import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/history/historyModel/historyModel.dart';
import 'package:finapp/models/history/recentDepositsAndWithdrawals/recentDepositsAndWithdrawals.dart';
import 'package:finapp/models/history/spendingByTagModel/spendingByTagModel.dart';
import 'package:finapp/models/history/tagPercentageModel/tagPercentageModel.dart';
import 'package:finapp/utils/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<RecentDepositsAndWithdrawals> getRecentDepositsAndWithdrawals() async {
  var dio = new Dio();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");
  dio.options.headers["Authorization"] = "Bearer $token";

  try {
    var response = await dio.get("${Config.API_URL}/history/recent-deposits-and-withdrawals");
    return RecentDepositsAndWithdrawals.fromJson(response.data);
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
      "${Config.API_URL}/history/total",
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
      data.add(new HistoryModel.fromJson(history));
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
      "${Config.API_URL}/history/account/$accountId",
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
      "${Config.API_URL}/history/tag-percentages",
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
      "${Config.API_URL}/history/spending-by-tag",
    );

    for (var spendingByTag in response.data) {
      data.add(new SpendingByTagModel.fromJson(spendingByTag));
    }

    data.sort((a, b) => a.amount.compareTo(b.amount));

    return data.reversed.toList();
  } finally {
    dio.close();
  }
}

import 'package:dio/dio.dart';
import 'package:finapp/models/history.dart';
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
      queryParameters: {
        "userId": userId,
      },
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
        "userId": userId,
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

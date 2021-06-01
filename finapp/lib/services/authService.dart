library change_service;

import 'package:dio/dio.dart';
import "../constants/apiConstants.dart";

Future login() async {
  var dio = new Dio();
  try {
    var uriResponse = await dio.post(apiUrl);
    print(uriResponse);
  } finally {
    dio.close();
  }
  return [];
}

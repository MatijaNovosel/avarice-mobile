library change_service;

import 'dart:convert';
import 'package:http/http.dart' as http;
import "../models/financial-change.dart";
import "../constants/api-constants.dart";

List<FinancialChange> parseFinancialChanges(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  return parsed["data"]["financialChanges"]
      .map<FinancialChange>((json) => FinancialChange.fromJson(json))
      .toList();
}

Future<List<FinancialChange>> function() async {
  var client = http.Client();
  try {
    var uriResponse = await client.post(Uri.parse(apiUrl),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({
          'query': '''query {
            financialChanges(id: 1) {
              id
              amount
              createdAt
              description
              expense
              paymentSourceId
              tagIds
            }
          }'''
        }));
    List<FinancialChange> res = parseFinancialChanges(uriResponse.body);
    return res;
  } finally {
    client.close();
  }
}

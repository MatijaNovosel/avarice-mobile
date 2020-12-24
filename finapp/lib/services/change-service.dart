library change_service;

import 'dart:convert';
import 'package:http/http.dart' as http;
import "../models/financial-change.dart";

List<FinancialChange> parseFinancialChanges(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();

  return parsed["data"]["financialChanges"]
      .map<FinancialChange>((json) => FinancialChange.fromJson(json))
      .toList();
}

final String apiUrl = "http://192.168.1.111:3000/graphql";

Future<List<FinancialChange>> function() async {
  print("test");
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

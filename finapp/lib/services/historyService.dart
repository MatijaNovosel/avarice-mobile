import 'dart:convert';
import 'package:finapp/models/account.dart';
import 'package:http/http.dart' as http;
import "../constants/apiConstants.dart";

List<Account> parseCurrentAmount(String responseBody) {
  return [];
}

Future<List<Account>> getCurrentAmount() async {
  var client = http.Client();
  try {
    var uriResponse = await client.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json"
      },
      body: json.encode(
        {
          'query': '''query {
            financialHistoryCurrentAmount(id: 1) {
              paymentSources {
                id
                amount
                description
              }
            }
          }'''
        },
      ),
    );
    return parseCurrentAmount(uriResponse.body);
  } finally {
    client.close();
  }
}

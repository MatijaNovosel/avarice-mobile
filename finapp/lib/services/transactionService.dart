library transaction_service;

import 'dart:convert';
import '../models/transaction.dart';

List<Transaction> parseTransactions(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  return parsed["data"]["transactions"]["items"]
      .map<Transaction>((json) => Transaction.fromJson(json))
      .toList();
}

Future<List<Transaction>> getTransactions() async {
  /*
  var client = http.Client();
  try {
    var uriResponse = await client.post(Uri.parse(apiUrl),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({
          'query': '''query {
            transactions(id: 1, take: 13, skip: 0) {
              count
              items {
                id
                amount
                createdAt
                description
                expense
                paymentSourceId
                tagIds
              }
            }
          }'''
        }));
    return parseTransactions(uriResponse.body);
  } finally {
    client.close();
  }
  */
  return [];
}

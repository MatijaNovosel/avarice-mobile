library change_service;

import 'dart:convert';

import 'package:http/http.dart' as http;

class FinancialChange {
  int id;
  double amount;
  String createdAt;
  String description;
  bool expense;
  int paymentSourceId;
  int appUserId;
  List<int> tagIds;

  @override
  String toString() {
    return '{amount: ${this.amount}, createdAt: ${this.createdAt}, description: ${this.description}}';
  }

  FinancialChange(
      {this.id,
      this.amount,
      this.createdAt,
      this.description,
      this.expense,
      this.paymentSourceId,
      this.appUserId,
      this.tagIds});

  factory FinancialChange.fromJson(Map<String, dynamic> json) {
    return FinancialChange(
        amount: json['amount'] == null ? 0.0 : json['amount'].toDouble(),
        appUserId: json['appUserId'] as int,
        createdAt: json['createdAt'] as String,
        description: json['description'] as String,
        expense: json['expense'] as bool,
        id: json['id'] as int,
        paymentSourceId: json['paymentSourceId'] as int,
        tagIds: json['tagIds'].cast<int>());
  }
}

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

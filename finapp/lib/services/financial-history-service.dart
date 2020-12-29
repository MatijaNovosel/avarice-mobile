import 'dart:convert';
import 'package:finapp/models/payment-source.dart';
import 'package:http/http.dart' as http;
import "../constants/api-constants.dart";

List<PaymentSource> parseCurrentAmount(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<String, dynamic>();
  return parsed["data"]["financialHistoryCurrentAmount"]["paymentSources"]
      .map<PaymentSource>(
        (json) => PaymentSource.fromJson(json),
      )
      .toList();
}

Future<List<PaymentSource>> getCurrentAmount() async {
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

import 'package:finapp/models/transaction.dart';
import 'package:finapp/popupTemplates/transactionDetails.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:finapp/widgets/historyTable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final Future<List<Transaction>> _transactions = getTransactions();

  void _openTransactionDetailsPopup() {
    final popup = BeautifulPopup.customize(
      context: context,
      build: (options) => TransactionDetailsPopup(options),
    );
    popup.show(
      title: 'Transaction details',
      content: Container(
        child: Text("Haha"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transaction>>(
        future: _transactions,
        builder: (context, AsyncSnapshot<List<Transaction>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(
                  child: SpinKitFoldingCube(
                    color: Colors.orange,
                    size: 50.0,
                  ),
                );
              }
            default:
              {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return HistoryTable(transactions: snapshot.data);
                }
              }
          }
        });
  }
}

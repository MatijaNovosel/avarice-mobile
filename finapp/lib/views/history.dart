import 'package:finapp/models/transaction.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final Future<List<Transaction>> _transactions = getTransactions();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder<List<Transaction>>(
              future: _transactions,
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Transaction>> snapshot,
              ) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: SpinKitFadingCircle(
                            color: Colors.grey[500],
                            size: 50.0,
                          ),
                        ),
                      );
                    }
                  default:
                    {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return DataTable(
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Amount',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Details',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            for (var transaction in snapshot.data)
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Text(transaction.description),
                                  ),
                                  DataCell(
                                    Text(
                                      "${NumberFormat("#,##0.00").format(transaction.amount)}",
                                    ),
                                  ),
                                  DataCell(
                                    TextButton(
                                      onPressed: () {},
                                      child: new Icon(
                                        Icons.more_horiz_rounded,
                                        color: Colors.grey,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        );
                      }
                    }
                }
              }),
        ],
      ),
    );
  }
}

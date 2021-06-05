import 'package:finapp/models/history.dart';
import 'package:finapp/models/transaction.dart';
import 'package:finapp/services/historyService.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:finapp/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final Future<List<Transaction>> _transactions = getTransactions();
  final Future<List<HistoryModel>> _history = getTotalHistory();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          _transactions,
          _history,
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(
                  child: SpinKitFoldingCube(
                    color: Colors.grey[500],
                    size: 50.0,
                  ),
                );
              }
            default:
              {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  var transactions = snapshot.data[0];
                  var history = snapshot.data[1];

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: HistoryTotalChart(history: history),
                      ),
                      const Divider(
                        height: 10,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              DataTable(
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
                                  for (var transaction in transactions)
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
          }
        });
  }
}

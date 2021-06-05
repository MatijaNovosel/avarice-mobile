import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/transaction.dart';
import 'package:finapp/services/transactionService.dart';
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
                  return Column(
                    children: [
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
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Amount',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'Details',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[500],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: snapshot.data
                                      .map(
                                        (t) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              Text(
                                                t.description,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Text(formatHrk(t.amount)),
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
                                      )
                                      .toList()),
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

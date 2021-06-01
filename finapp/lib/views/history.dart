import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
              for (var i = 0; i < 50; i++)
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text('Description'),
                    ),
                    DataCell(
                      Text('250HRK'),
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
    );
  }
}

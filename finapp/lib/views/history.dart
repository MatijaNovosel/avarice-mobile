import 'package:finapp/controllers/form-submit-controller.dart';
import 'package:finapp/widgets/tag.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final FormSubmitController formSubmitController = FormSubmitController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
      ),
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          DataColumn(
            label: Text(
              'Amount',
              style: TextStyle(fontWeight: FontWeight.bold),
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
          for (var i = 0; i < 25; i++)
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Description')),
                DataCell(Text('250HRK')),
                DataCell(
                  FlatButton(
                    onPressed: () {},
                    child: new Icon(
                      Icons.more_horiz_rounded,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    shape: new CircleBorder(),
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
        ],
      ), // ExpenseForm(controller: formSubmitController),
    );
  }
}

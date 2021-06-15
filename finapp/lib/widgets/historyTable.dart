import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/transaction.dart';
import 'package:finapp/popupTemplates/transactionDetails.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HistoryTable extends StatefulWidget {
  final List<Transaction> transactions;

  HistoryTable({
    Key key,
    this.transactions,
  }) : super(key: key);

  @override
  _HistoryTableState createState() => _HistoryTableState();
}

class _HistoryTableState extends State<HistoryTable> {
  List<Transaction> transactions = <Transaction>[];
  TransactionDataSource transactionDataSource;

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
  void initState() {
    super.initState();
    transactions = widget.transactions;
    transactionDataSource = TransactionDataSource(
      transactionData: transactions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfDataGrid(
        source: transactionDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridTextColumn(
            columnName: 'description',
            label: Container(
              alignment: Alignment.center,
              child: Text('Description'),
            ),
          ),
          GridTextColumn(
            columnName: 'amount',
            label: Container(
              alignment: Alignment.center,
              child: Text(
                'Amount',
              ),
            ),
          ),
          GridTextColumn(
            columnName: 'actions',
            label: Container(
              alignment: Alignment.center,
              child: Text(
                "Actions",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Transaction>> getTransactionData() async {
    var transactions = await getTransactions(0, 15);
    return transactions;
  }
}

class TransactionDataSource extends DataGridSource {
  TransactionDataSource({List<Transaction> transactionData}) {
    _transactionData = transactionData
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'description',
                value: e.description,
              ),
              DataGridCell<dynamic>(
                columnName: 'amount',
                value: {
                  "expense": e.expense,
                  "amount": e.amount,
                },
              ),
              DataGridCell<int>(
                columnName: 'actions',
                value: e.id,
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _transactionData = [];

  @override
  List<DataGridRow> get rows => _transactionData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (e) {
          switch (e.columnName) {
            case "amount":
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: e.value["expense"] == true ? Colors.red : Colors.green,
                ),
                child: Text(
                  formatHrk(
                    e.value["amount"].toDouble(),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            case "actions":
              return IconButton(
                onPressed: () {
                  print(e.value);
                },
                icon: Icon(
                  Icons.keyboard_control_rounded,
                ),
              );
            default:
              return Container(
                alignment: Alignment.center,
                child: Text(
                  e.value.toString(),
                ),
              );
          }
        },
      ).toList(),
    );
  }
}

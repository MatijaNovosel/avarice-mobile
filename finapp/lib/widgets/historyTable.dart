import 'package:finapp/models/transaction.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    transactions = widget.transactions;
    transactionDataSource =
        TransactionDataSource(transactionData: transactions);
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
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text('Description'),
            ),
          ),
          GridTextColumn(
            columnName: 'amount',
            label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                'Amount',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridTextColumn(
            columnName: 'createdAt',
            label: Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                'Created at',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Transaction>> getTransactionData() async {
    var transactions = await getTransactions();
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
                  columnName: 'description', value: e.description),
              DataGridCell<double>(columnName: 'amount', value: e.amount),
              DataGridCell<String>(columnName: 'createdAt', value: e.createdAt),
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
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        },
      ).toList(),
    );
  }
}

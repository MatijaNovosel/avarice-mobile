import 'package:finapp/helpers/helpers.dart';
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
  List<Transaction> _transactions = <Transaction>[];
  TransactionDataSource transactionDataSource;

  @override
  void initState() {
    super.initState();
    _transactions = widget.transactions;
    transactionDataSource = TransactionDataSource(
      transactionData: _transactions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfDataGrid(
        loadMoreViewBuilder: (BuildContext context, LoadMoreRows loadMoreRows) {
          Future<String> loadRows() async {
            await loadMoreRows();
            return Future<String>.value('Completed');
          }

          return FutureBuilder<String>(
            initialData: 'loading',
            future: loadRows(),
            builder: (context, snapShot) {
              if (snapShot.data == 'loading') {
                return Container(
                  height: 60.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: BorderDirectional(
                      top: BorderSide(
                        width: 1.0,
                        color: Color.fromRGBO(0, 0, 0, 0.26),
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
                  ),
                );
              } else {
                return SizedBox.fromSize(size: Size.zero);
              }
            },
          );
        },
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
}

class TransactionDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];
  List<Transaction> _transactions = <Transaction>[];

  TransactionDataSource({List<Transaction> transactionData}) {
    _transactions = transactionData;
    buildDataGridRows();
  }

  List<DataGridRow> _transactionData = [];

  @override
  List<DataGridRow> get rows => _transactionData;

  @override
  Future<void> handleLoadMoreRows() async {
    await _addMoreRows(_transactions, 15);
    buildDataGridRows();
    notifyListeners();
  }

  Future<void> _addMoreRows(List<Transaction> transactions, int count) async {
    final startIndex = transactions.isNotEmpty ? transactions.length : 0, endIndex = startIndex + count;
    print(startIndex);
    print(endIndex);

    var data = await getTransactions(startIndex, endIndex);

    for (int i = 0; i < data.length; i++) {
      transactions.add(
        new Transaction(
          id: data[i].id,
          accountDescription: data[i].accountDescription,
          amount: data[i].amount,
          createdAt: data[i].createdAt,
          description: data[i].description,
          expense: data[i].expense,
        ),
      );
    }
  }

  void buildDataGridRows() {
    _transactionData = _transactions
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

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (e) {
          switch (e.columnName) {
            case "amount":
              return Container(
                alignment: Alignment.center,
                child: Text(
                  (e.value["expense"] ? "-" : "+") + '${formatHrk(e.value["amount"].toDouble())}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: e.value["expense"] == false ? Colors.green[300] : null,
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

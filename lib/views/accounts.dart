import 'package:finapp/models/history.dart';
import 'package:finapp/services/accountService.dart';
import 'package:finapp/services/historyService.dart';
import 'package:finapp/widgets/charts/totalHistoryChart.dart';
import 'package:finapp/widgets/currentAmountList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  int _accountId;
  List<HistoryModel> accountHistory;
  bool loaded = false;

  void sync(accountId) async {
    setState(() {
      loaded = false;
    });

    var history = await getTotalHistoryForAccount(accountId);

    setState(() {
      _accountId = accountId;
      accountHistory = history;
      loaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    (() async {
      var accounts = await getLatestAccountValues();
      sync(accounts[0].id);
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          loaded
              ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: _accountId != null
                      ? HistoryTotalChart(
                          history: accountHistory,
                        )
                      : Container(),
                )
              : Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: SpinKitFoldingCube(
                    color: Colors.orange,
                    size: 50.0,
                  ),
                ),
          CurrentAmountListWidget(
            onLoadingFinished: (id) {
              print(id);
            },
            onAccountChange: (id) {
              sync(id);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/account.dart';
import 'package:finapp/models/history.dart';
import 'package:finapp/services/accountService.dart';
import 'package:finapp/services/historyService.dart';
import 'package:finapp/widgets/currentAmountCard.dart';
import 'package:flutter/material.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:finapp/models/transaction.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Future<List<Transaction>> _transactions = getTransactions();
  final Future<List<Account>> _accounts = getLatestAccountValues();
  final Future<RecentDepositsAndWithdrawals> _recentDepositsAndWithdrawals = getRecentDepositsAndWithdrawals();

  void loadMore() {
    print("load moreeee");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: FutureBuilder(
        future: Future.wait([
          _accounts,
          _transactions,
          _recentDepositsAndWithdrawals,
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
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
                  var accounts = snapshot.data[0];
                  var transactions = snapshot.data[1];
                  var recentDepositsAndWithdrawals = snapshot.data[2];

                  return Column(
                    children: [
                      CurrentAmountCard(
                        account: Account(
                          amount: accounts.map((x) => x.amount).reduce((a, b) => a + b),
                          description: "Total",
                        ),
                        color: Colors.grey[600],
                        icon: Icons.account_balance_wallet_sharp,
                        showInitialValue: true,
                        gradient: true,
                        gradientFrom: Colors.orange[700],
                        gradientTo: Colors.red[400],
                        mainTextColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 8,
                        ),
                        child: CurrentAmountCard(
                          account: Account(
                            amount: recentDepositsAndWithdrawals.withdrawals,
                            description: "Recent withdrawals",
                          ),
                          color: Colors.red[300],
                          icon: Icons.arrow_back,
                          showHideButton: false,
                          showInitialValue: true,
                          gradient: true,
                          gradientFrom: Colors.red[900],
                          gradientTo: Colors.red[400],
                          mainTextColor: Colors.white,
                        ),
                      ),
                      CurrentAmountCard(
                        account: Account(
                          amount: recentDepositsAndWithdrawals.deposits,
                          description: "Recent deposits",
                        ),
                        color: Colors.green[300],
                        icon: Icons.arrow_forward,
                        showHideButton: false,
                        showInitialValue: true,
                        gradient: true,
                        gradientFrom: Colors.green[800],
                        gradientTo: Colors.green[400],
                        mainTextColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                          bottom: 6,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Recent transactions",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: LazyLoadScrollView(
                          onEndOfPage: () => loadMore(),
                          child: ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        DateTime.parse(transactions[index].createdAt).day.toString(),
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('MMM')
                                            .format(
                                              DateTime.parse(transactions[index].createdAt),
                                            )
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 4.0),
                                        child: Text(
                                          '${transactions[index].description}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        (transactions[index].expense ? "-" : "+") + '${formatHrk(transactions[index].amount)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: transactions[index].expense == false ? Colors.green[300] : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
          }
        },
      ),
    );
  }
}

import 'package:finapp/models/account.dart';
import 'package:finapp/models/history.dart';
import 'package:finapp/services/accountService.dart';
import 'package:finapp/services/historyService.dart';
import 'package:finapp/widgets/currentAmountCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:finapp/models/transaction.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timelines/timelines.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Future<List<Transaction>> _transactions = getTransactions();
  final Future<List<Account>> _accounts = getLatestAccountValues();
  final Future<RecentDepositsAndWithdrawals> _recentDepositsAndWithdrawals =
      getRecentDepositsAndWithdrawals();

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
                  child: SpinKitFadingCircle(
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
                  var accounts = snapshot.data[0];
                  var transactions = snapshot.data[1];
                  var recentDepositsAndWithdrawals = snapshot.data[2];

                  return Column(
                    children: [
                      CurrentAmountCardWidget(
                        account: Account(
                          amount: accounts
                              .map((x) => x.amount)
                              .reduce((a, b) => a + b),
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
                        child: CurrentAmountCardWidget(
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
                      CurrentAmountCardWidget(
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
                          top: 23.0,
                          bottom: 12,
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
                        child: SingleChildScrollView(
                          child: FixedTimeline.tileBuilder(
                            builder: TimelineTileBuilder.connectedFromStyle(
                              contentsAlign: ContentsAlign.alternating,
                              oppositeContentsBuilder: (context, index) =>
                                  Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  "${DateFormat("dd.MM.yyyy. HH:mm:ss").format(DateTime.parse(transactions[index].createdAt))}",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              contentsBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10,
                                ),
                                child: Card(
                                  child: Container(
                                    padding: EdgeInsets.all(14.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transactions[index].description,
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5.0,
                                          ),
                                          child: Text(
                                            "${NumberFormat("#,##0.00", "hr_HR").format(transactions[index].amount)} HRK",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  transactions[index].expense ==
                                                          true
                                                      ? Colors.red[300]
                                                      : Colors.green[400],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              connectorStyleBuilder: (context, index) =>
                                  ConnectorStyle.solidLine,
                              indicatorStyleBuilder: (context, index) {
                                if (index + 1 >= transactions.length) {
                                  return IndicatorStyle.outlined;
                                }

                                var date = DateTime.parse(
                                    transactions[index].createdAt);
                                var compareDate = DateTime.parse(
                                    transactions[index + 1].createdAt);

                                if (date.day == compareDate.day &&
                                    date.month == compareDate.month) {
                                  return IndicatorStyle.dot;
                                }

                                return IndicatorStyle.outlined;
                              },
                              itemCount: transactions.length,
                            ),
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

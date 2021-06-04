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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(children: [
              FutureBuilder(
                future: _accounts,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<Account>> snapshot,
                ) {
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
                          return CurrentAmountCardWidget(
                            account: Account(
                              amount: snapshot.data
                                  .map((x) => x.amount)
                                  .reduce((a, b) => a + b),
                              description: "Total",
                            ),
                            color: Colors.grey[600],
                            icon: Icons.account_balance_wallet_sharp,
                            showInitialValue: true,
                          );
                        }
                      }
                  }
                },
              ),
              FutureBuilder<RecentDepositsAndWithdrawals>(
                future: _recentDepositsAndWithdrawals,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<RecentDepositsAndWithdrawals> snapshot,
                ) {
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
                          return Column(
                            children: [
                              CurrentAmountCardWidget(
                                account: Account(
                                  amount: snapshot.data.withdrawals,
                                  description: "Recent withdrawals",
                                ),
                                color: Colors.red[300],
                                icon: Icons.arrow_back,
                                showHideButton: false,
                                showInitialValue: true,
                              ),
                              CurrentAmountCardWidget(
                                account: Account(
                                  amount: snapshot.data.deposits,
                                  description: "Recent deposits",
                                ),
                                color: Colors.green[300],
                                icon: Icons.arrow_forward,
                                showHideButton: false,
                                showInitialValue: true,
                              ),
                            ],
                          );
                        }
                      }
                  }
                },
              ),
            ]),
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
          FutureBuilder<List<Transaction>>(
            future: _transactions,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<Transaction>> snapshot,
            ) {
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
                      return Expanded(
                          child: SingleChildScrollView(
                        child: FixedTimeline.tileBuilder(
                          builder: TimelineTileBuilder.connectedFromStyle(
                            contentsAlign: ContentsAlign.alternating,
                            oppositeContentsBuilder: (context, index) =>
                                Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                "${DateFormat("dd.MM.yyyy. HH:mm:ss").format(DateTime.parse(snapshot.data[index].createdAt))}",
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
                                        snapshot.data[index].description,
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5.0,
                                        ),
                                        child: Text(
                                          "${NumberFormat("#,##0.00", "hr_HR").format(snapshot.data[index].amount)} HRK",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                snapshot.data[index].expense ==
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
                              if (index + 1 >= snapshot.data.length) {
                                return IndicatorStyle.outlined;
                              }

                              var date = DateTime.parse(
                                  snapshot.data[index].createdAt);
                              var compareDate = DateTime.parse(
                                  snapshot.data[index + 1].createdAt);

                              if (date.day == compareDate.day &&
                                  date.month == compareDate.month) {
                                return IndicatorStyle.dot;
                              }

                              return IndicatorStyle.outlined;
                            },
                            itemCount: snapshot.data.length,
                          ),
                        ),
                      ));
                    }
                  }
              }
            },
          ),
        ],
      ),
    );
  }
}

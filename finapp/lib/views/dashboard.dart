import 'package:finapp/models/account.dart';
import 'package:finapp/models/history.dart';
import 'package:finapp/services/accountService.dart';
import 'package:finapp/services/historyService.dart';
import 'package:finapp/widgets/currentAmountCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:finapp/models/transaction.dart';
import "package:finapp/widgets/transactionCard.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CurrentAmountListWidget(onPaymentSourceChanged: (id) {}),
          Container(
            padding: EdgeInsets.only(top: 4),
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
                            color: Colors.red,
                            size: 50.0,
                          ),
                        );
                      }
                    default:
                      {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 15,
                            ),
                            child: CurrentAmountCardWidget(
                              account: Account(
                                amount: snapshot.data
                                    .map((x) => x.amount)
                                    .reduce((a, b) => a + b),
                                description: "Total",
                              ),
                              color: Colors.white,
                              icon: Icons.account_balance_wallet_sharp,
                            ),
                          );
                        }
                      }
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Stack(
                  children: [
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
                                  color: Colors.red,
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
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            height: 20,
                                            child: LinearProgressIndicator(
                                              backgroundColor: Colors.red[900],
                                              value: snapshot.data.withdrawals /
                                                  (snapshot.data.withdrawals +
                                                      snapshot.data.deposits),
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                Colors.red[700],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 3.0,
                                            ),
                                            child: Text(
                                              "${NumberFormat("#,##0.00", "hr_HR").format(snapshot.data.withdrawals)} HRK",
                                              style: TextStyle(
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              height: 20,
                                              child: LinearProgressIndicator(
                                                backgroundColor:
                                                    Colors.green[900],
                                                value: snapshot.data.deposits /
                                                    (snapshot.data.withdrawals +
                                                        snapshot.data.deposits),
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                  Colors.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 3.0,
                                              ),
                                              child: Text(
                                                "${NumberFormat("#,##0.00", "hr_HR").format(snapshot.data.deposits)} HRK",
                                                style: TextStyle(
                                                  color: Colors.grey[300],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }
                        }
                      },
                    ),
                  ],
                ),
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
                    fontSize: 16,
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
                        color: Colors.red,
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
                        child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return Column(
                              children: [
                                TransactionCardWidget(
                                  transaction: snapshot.data[i],
                                  visible: true,
                                ),
                                SizedBox(height: 12),
                              ],
                            );
                          },
                        ),
                      );
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

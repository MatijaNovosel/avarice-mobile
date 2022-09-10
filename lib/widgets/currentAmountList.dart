import 'package:finapp/models/account.dart';
import 'package:finapp/services/accountService.dart';
import 'package:finapp/widgets/currentAmountCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

typedef PaymentSourceIdCallback = void Function(int paymentSourceId);
typedef OnLoadingFinishedCallback = void Function(int accountId);

class CurrentAmountListWidget extends StatefulWidget {
  final PaymentSourceIdCallback onAccountChange;
  final OnLoadingFinishedCallback? onLoadingFinished;

  const CurrentAmountListWidget({
    required this.onAccountChange,
    this.onLoadingFinished,
  });

  @override
  _CurrentAmountListState createState() => _CurrentAmountListState();
}

class _CurrentAmountListState extends State<CurrentAmountListWidget> {
  int _index = 0;
  Future<List<Account>> _future = getLatestAccountValues();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Account>>(
      future: _future,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Account>> snapshot,
      ) {
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
                var accounts = snapshot.data;

                return Column(
                  children: [
                    SizedBox(
                      height: 55,
                      child: PageView.builder(
                        itemCount: accounts!.length,
                        onPageChanged: (i) {
                          widget.onAccountChange(accounts[i].id);
                          setState(() {
                            _index = i;
                          });
                        },
                        itemBuilder: (_, i) {
                          return Transform.scale(
                            scale: i == _index ? 1 : 0.9,
                            child: CurrentAmountCard(
                              icon: Icons.account_balance_wallet,
                              color: Colors.grey[600],
                              account: accounts[i],
                              showHideButton: true,
                              showInitialValue: true,
                              gradient: true,
                              gradientFrom: Colors.orange[700],
                              gradientTo: Colors.red[400],
                              mainTextColor: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(
                        top: 12,
                      ),
                      child: ListView.builder(
                        itemCount: accounts.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, i) {
                          return Transform.scale(
                            scale: i == _index ? 1 : 0.7,
                            child: Container(
                              width: 10,
                              height: 10,
                              margin: i != accounts.length ? EdgeInsets.only(right: 4) : null,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: i == _index ? Colors.orange : Colors.grey[400],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }
        }
      },
    );
  }
}

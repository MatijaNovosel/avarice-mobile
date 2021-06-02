import 'package:finapp/models/account.dart';
import 'package:finapp/services/accountService.dart';
import 'package:finapp/widgets/currentAmountCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

typedef PaymentSourceIdCallback = void Function(int paymentSourceId);

class CurrentAmountListWidget extends StatefulWidget {
  const CurrentAmountListWidget({this.onAccountChange});
  final PaymentSourceIdCallback onAccountChange;

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
                    SizedBox(
                      height: 80,
                      child: PageView.builder(
                        itemCount: snapshot.data.length,
                        onPageChanged: (i) {
                          widget.onAccountChange(i);
                          setState(() {
                            _index = i;
                          });
                        },
                        itemBuilder: (_, i) {
                          return Transform.scale(
                            scale: i == _index ? 1 : 0.9,
                            child: CurrentAmountCardWidget(
                              icon: Icons.account_balance_wallet,
                              color: Colors.white,
                              account: snapshot.data[i],
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
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, i) {
                          return Transform.scale(
                            scale: i == _index ? 1 : 0.7,
                            child: Container(
                              width: 10,
                              height: 10,
                              margin: i != snapshot.data.length
                                  ? EdgeInsets.only(right: 4)
                                  : null,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: i == _index
                                    ? Colors.white
                                    : Colors.grey[800],
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

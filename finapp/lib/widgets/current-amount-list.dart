import 'package:finapp/models/payment-source.dart';
import 'package:finapp/services/financial-history-service.dart';
import 'package:finapp/widgets/current-amount-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

typedef PaymentSourceIdCallback = void Function(int paymentSourceId);

class CurrentAmountListWidget extends StatefulWidget {
  const CurrentAmountListWidget({this.onPaymentSourceChanged});
  final PaymentSourceIdCallback onPaymentSourceChanged;

  @override
  _CurrentAmountListState createState() => _CurrentAmountListState();
}

class _CurrentAmountListState extends State<CurrentAmountListWidget> {
  int _index = 0;
  Future<List<PaymentSource>> _future;

  @override
  void initState() {
    _future = getCurrentAmount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PaymentSource>>(
      future: _future,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<PaymentSource>> snapshot,
      ) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            {
              return Center(
                child: SpinKitThreeBounce(
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
                      height: 70,
                      child: PageView.builder(
                        itemCount: snapshot.data.length,
                        onPageChanged: (i) {
                          widget.onPaymentSourceChanged(i);
                          setState(() {
                            _index = i;
                          });
                        },
                        itemBuilder: (_, i) {
                          return Transform.scale(
                            scale: i == _index ? 1 : 0.9,
                            child: CurrentAmountCardWidget(
                              icon: Icons.account_balance_wallet,
                              color: Colors.orange[600],
                              paymentSource: snapshot.data[i],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 25,
                      margin: EdgeInsets.only(
                        top: 12,
                        bottom: 8,
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
                                    ? Colors.orange
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

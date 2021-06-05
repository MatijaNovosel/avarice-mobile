import 'package:finapp/models/account.dart';
import 'package:finapp/services/accountService.dart';
import 'package:finapp/widgets/currentAmountCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final Future<List<Account>> _accounts = getLatestAccountValues();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: FutureBuilder<List<Account>>(
        future: _accounts,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Account>> snapshot,
        ) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(
                  child: SpinKitFoldingCube(
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
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return Column(
                              children: [
                                CurrentAmountCardWidget(
                                  account: Account(
                                    amount: snapshot.data[i].amount,
                                    description: snapshot.data[i].description,
                                  ),
                                  color: Colors.grey[600],
                                  icon: Icons.account_balance_wallet_sharp,
                                  showInitialValue: true,
                                  gradient: true,
                                  gradientFrom: Colors.orange[700],
                                  gradientTo: Colors.red[400],
                                  mainTextColor: Colors.white,
                                ),
                                SizedBox(height: 5),
                              ],
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
      ),
    );
  }
}

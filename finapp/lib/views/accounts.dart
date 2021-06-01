import 'package:finapp/models/account.dart';
import 'package:finapp/services/accountService.dart';
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
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
      ),
      child: Column(
        children: [
          FutureBuilder<List<Account>>(
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
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return Column(
                              children: [
                                Card(
                                  child: ListTile(
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12.0,
                                      ),
                                      child: Text(
                                        "${NumberFormat("#,##0.00", "hr_HR").format(snapshot.data[i].amount)} HRK",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12.0,
                                      ),
                                      child: Text(
                                        snapshot.data[i].description,
                                      ),
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                  ),
                                ),
                                SizedBox(height: 5),
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

import 'package:finapp/models/account.dart';
import 'package:finapp/services/accountService.dart';
import 'package:flutter/material.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  List<Account> _accounts;

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
          Text("Accounts"),
          ElevatedButton(
            onPressed: () async {
              var accounts = await getLatestAccountValues();
              setState(() {
                _accounts = accounts;
              });
            },
            child: Text("Fetch accounts"),
          ),
          Column(
            children: [
              if (_accounts != null && _accounts.length != 0)
                for (var account in _accounts)
                  Card(
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.account_balance_wallet_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      title: Text(account.amount.toStringAsFixed(2) + " HRK"),
                      subtitle: Text(account.description),
                      trailing: Icon(Icons.more_vert),
                    ),
                  ),
            ],
          )
        ],
      ),
    );
  }
}

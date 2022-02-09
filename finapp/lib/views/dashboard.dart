import 'package:finapp/models/account.dart';
import 'package:finapp/models/tag.dart';
import 'package:finapp/models/transaction.dart';
import 'package:finapp/widgets/currentAmountCard.dart';
import 'package:finapp/widgets/transactionCard.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _index = 0;
  List<Account> _accounts = [
    Account(amount: 250, description: "Total", id: 1),
    Account(amount: 2500, description: "Gyro", id: 2),
    Account(amount: 125, description: "Pocket", id: 3),
    Account(amount: 55, description: "Credit", id: 4)
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: 125,
                child: PageView.builder(
                  itemCount: _accounts.length,
                  onPageChanged: (i) {
                    setState(() {
                      _index = i;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Transform.scale(
                      scale: i == _index ? 1 : 0.9,
                      child: CurrentAmountCard(
                        height: 125,
                        account: _accounts[i],
                        showHideButton: true,
                        showInitialValue: true,
                        gradient: true,
                        gradientFrom: Colors.purple[700],
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
                  itemCount: _accounts.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) {
                    return Transform.scale(
                      scale: i == _index ? 1 : 0.7,
                      child: Container(
                        width: 10,
                        height: 10,
                        margin: i != _accounts.length ? EdgeInsets.only(right: 4) : null,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == _index ? Color(0xFF2F4562) : Colors.grey[400],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 12,
            ),
            child: Text(
              "Recent transactions",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                  .map<Widget>(
                    (n) => Padding(
                      padding: EdgeInsets.only(
                        bottom: n == 10 ? 0.0 : 8.0,
                      ),
                      child: TransactionCardWidget(
                        visible: true,
                        transaction: Transaction(
                          accountDescription: "",
                          amount: (n % 2 == 0 ? -n : n) * 250.0,
                          createdAt: "21 Feb 2022 14:34",
                          description: (['Food', 'Books', 'Drink', 'Rent', 'Salary'].toList()..shuffle()).first,
                          expense: n % 2 == 0,
                          id: n,
                          tags: [
                            Tag(
                              description: "Test",
                              id: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

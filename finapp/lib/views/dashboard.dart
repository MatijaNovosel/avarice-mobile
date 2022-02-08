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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 6,
      ),
      child: Column(
        children: [
          CurrentAmountCard(
            height: 100,
            account: Account(
              amount: 2500,
              description: "Total",
            ),
            showInitialValue: true,
            gradient: true,
            gradientFrom: Colors.purple,
            gradientTo: Colors.red[400],
            mainTextColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent transactions",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "View all",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_sharp,
                      size: 24,
                      color: Colors.redAccent,
                    )
                  ],
                ),
              ],
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
                          accountDescription: "Item $n",
                          amount: (n % 2 == 0 ? -n : n) * 250.0,
                          createdAt: "21.02.2022. 14:34",
                          description: "Item $n",
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

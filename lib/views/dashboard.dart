import 'package:carousel_slider/carousel_slider.dart';
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
              CarouselSlider(
                options: CarouselOptions(
                  height: 115.0,
                  onPageChanged: (i, reason) {
                    setState(
                      () {
                        _index = i;
                      },
                    );
                  },
                ),
                items: _accounts.map(
                  (account) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CurrentAmountCard(
                          account: account,
                          height: 135,
                          width: MediaQuery.of(context).size.width,
                          margin: 8.0,
                          showInitialValue: true,
                        );
                      },
                    );
                  },
                ).toList(),
              ),
              Container(
                height: 25,
                margin: EdgeInsets.only(
                  top: 6,
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
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    bottom: 8,
                  ),
                  child: Text(
                    "Today",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                ...[1, 2, 3]
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    bottom: 8,
                  ),
                  child: Text(
                    "Yesterday",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                ...[1, 2, 3]
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    bottom: 8,
                  ),
                  child: Text(
                    "15 February",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                ...[1, 2, 3]
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

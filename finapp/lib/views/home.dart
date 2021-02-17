import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finapp/widgets/app-bar.dart';
import 'package:finapp/widgets/bottom-navigation.dart';
import 'package:finapp/widgets/current-amount-list.dart';
import 'package:finapp/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:finapp/services/change-service.dart';
import "package:finapp/models/financial-change.dart";
import "package:finapp/widgets/change-card.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final Future<List<FinancialChange>> _financialChanges = getFinancialChanges();

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
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 20,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.red[900],
                        value: 0.5,
                        valueColor: AlwaysStoppedAnimation(Colors.red),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        "${NumberFormat("#,##0.00", "hr_HR").format(14000 * 0.05)} HRK",
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 20,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.green[900],
                          value: 0.5,
                          valueColor: AlwaysStoppedAnimation(Colors.green),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          "${NumberFormat("#,##0.00", "hr_HR").format(6400 * 0.12)} HRK",
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
              bottom: 12,
            ),
            child: Row(
              children: [
                Text(
                  "Financial changes",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          Icons.download_rounded,
                          color: Colors.grey[400],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.filter_alt_rounded,
                            color: Colors.grey[400],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey[400],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          /* FutureBuilder<List<FinancialChange>>(
            future: _financialChanges,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<FinancialChange>> snapshot,
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
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return Column(
                              children: [
                                ChangeCardWidget(
                                  financialChange: snapshot.data[i],
                                  visible: false,
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
          ), */
        ],
      ),
    );
  }
}

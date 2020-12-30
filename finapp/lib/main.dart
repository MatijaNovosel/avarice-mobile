import 'package:finapp/models/payment-source.dart';
import 'package:finapp/services/financial-history-service.dart';
import 'package:finapp/widgets/current-amount-card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'services/change-service.dart';
import "models/financial-change.dart";
import "widgets/change-card.dart";
import "widgets/app-bar.dart";
import "widgets/drawer.dart";
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "views/new-entry.dart";

Future<Null> _read() async {
  List<OcrText> texts = [];
  try {
    texts = await FlutterMobileVision.read(
      camera: FlutterMobileVision.CAMERA_BACK,
      waitTap: true,
      showText: true,
    );
  } on Exception {
    texts.add(
      OcrText('Failed to recognize text'),
    );
  }
}

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      routes: {
        '/': (context) => Home(),
        '/details': (context) => NewEntry(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<Home> {
  final Future<List<FinancialChange>> _financialChanges = getFinancialChanges();
  final Future<List<PaymentSource>> _paymentSources = getCurrentAmount();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    // FlutterMobileVision.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
        ),
        child: Column(
          children: [
            FutureBuilder<List<PaymentSource>>(
              future: _paymentSources,
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
                              height: 100,
                              child: PageView.builder(
                                itemCount: snapshot.data.length,
                                onPageChanged: (int index) => setState(
                                  () => _index = index,
                                ),
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
                              margin: EdgeInsets.only(top: 4),
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
                                      margin: i != 3
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
            ),
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
              child: Text(
                "Financial changes",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            FutureBuilder<List<FinancialChange>>(
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
                                  SizedBox(
                                    height: 12,
                                  ),
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
      ),
      drawer: CustomDrawer(),
      floatingActionButton: SizedBox(
        height: 48,
        width: 48,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewEntry(),
              ),
            );
          },
          backgroundColor: Colors.green[600],
          foregroundColor: Colors.white,
          child: Icon(
            Icons.create_rounded,
          ),
        ),
      ),
    );
  }
}

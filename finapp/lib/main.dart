import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finapp/widgets/current-amount-list.dart';
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
    print(texts[0].value);
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

  @override
  void initState() {
    super.initState();
    FlutterMobileVision.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: CustomAppBar(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey[850],
        color: Colors.grey[800],
        height: 55,
        items: <Widget>[
          Icon(Icons.home, size: 25),
          Icon(Icons.create_rounded, size: 25),
          Icon(Icons.history, size: 25),
          Icon(Icons.credit_card_outlined, size: 25),
        ],
        onTap: (index) {
          // Handle button tap
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurrentAmountListWidget(onPaymentSourceChanged: (id) {}),
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
    );
  }
}

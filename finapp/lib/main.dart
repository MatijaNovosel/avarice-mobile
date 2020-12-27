import 'package:flutter/material.dart';
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
        fontFamily: 'ProximaNova',
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
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                bottom: 20,
              ),
              child: Text(
                "Financial changes",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            FutureBuilder<List<FinancialChange>>(
              future: getFinancialChanges(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<FinancialChange>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    {
                      return Center(
                        child: SpinKitSquareCircle(
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
                            shrinkWrap: true,
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
            Navigator.pushNamed(
              context,
              '/details',
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

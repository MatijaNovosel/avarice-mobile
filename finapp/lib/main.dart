import 'package:flutter/material.dart';
import 'services/change-service.dart';
import "models/financial-change.dart";
import "widgets/change-card.dart";
import "widgets/app-bar.dart";
import "widgets/drawer.dart";

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'ProximaNova', brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: FutureBuilder<List<FinancialChange>>(
          future: getFinancialChanges(),
          builder: (BuildContext context,
              AsyncSnapshot<List<FinancialChange>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                      valueColor: AlwaysStoppedAnimation(Colors.red[900]),
                    ),
                  );
                }
              default:
                {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            SizedBox(height: 12),
                            ChangeCardWidget(
                              financialChange: snapshot.data[i],
                            ),
                            i == snapshot.data.length - 1
                                ? SizedBox(height: 12)
                                : Container(),
                          ],
                        );
                      },
                    );
                  }
                }
            }
          },
        ),
      ),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.camera_alt_rounded),
        backgroundColor: Colors.orange,
        label: Text("Scan"),
      ),
    );
  }
}

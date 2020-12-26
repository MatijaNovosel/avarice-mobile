import 'package:flutter/material.dart';
import 'services/change-service.dart';
import "models/financial-change.dart";
import "widgets/change-card.dart";
import "widgets/app-bar.dart";
import "widgets/drawer.dart";

void main() => runApp(Main());

class FinancialChanges extends StatefulWidget {
  final List<FinancialChange> financialChanges;
  const FinancialChanges({this.financialChanges});

  @override
  _FinancialChangesState createState() => _FinancialChangesState();
}

class _FinancialChangesState extends State<FinancialChanges> {
  final List<FinancialChange> _financialChanges = [];

  @override
  Widget build(BuildContext context) {
    return _buildFinancialChanges();
  }

  Widget _buildRow(FinancialChange fc) {
    return ListTile(title: Text("Bruh"));
  }

  Widget _buildFinancialChanges() {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (_financialChanges.length == 0) {
            return ListTile(title: Text("Bruh"));
          }

          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _financialChanges.length) {
            _financialChanges.addAll(widget.financialChanges.take(10));
          }
          return _buildRow(_financialChanges[index]);
        });
  }
}

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
        padding: const EdgeInsets.only(top: 12.0, left: 12, right: 12),
        child: FutureBuilder<List<FinancialChange>>(
          future: getFinancialChanges(),
          builder: (BuildContext context,
              AsyncSnapshot<List<FinancialChange>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                      valueColor: AlwaysStoppedAnimation(Colors.red[900]),
                    ),
                  ),
                );
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      final index = i ~/ 2;
                      if (i.isOdd)
                        return SizedBox(
                          height: 12,
                        );
                      return ChangeCardWidget(
                          financialChange: snapshot.data[index]);
                    },
                  );
            }
          },
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}

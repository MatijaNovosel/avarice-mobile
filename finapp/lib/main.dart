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
  bool _loading = false;
  List<FinancialChange> _financialChanges = [];

  void _setLoading(bool val) {
    setState(() {
      _loading = val;
    });
  }

  void _setData() async {
    _setLoading(true);
    List<FinancialChange> res = await function();
    setState(() {
      _financialChanges = res.take(10);
    });
    _setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: CustomAppBar(),
      body: Container(
          margin: EdgeInsets.only(top: 12, left: 12, right: 12),
          child: Row(children: [
            Expanded(
                child: _loading
                    ? CircularProgressIndicator()
                    : Column(children: [
                        ChangeCardWidget(
                          financialChange: new FinancialChange(
                              description: "Description",
                              amount: 125.50,
                              appUserId: 1,
                              createdAt: "24.10.2020. 14:30",
                              expense: true),
                        )
                      ]))
          ])),
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 138, 0),
        foregroundColor: Colors.grey[900],
        onPressed: _setData,
        tooltip: 'Get data',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

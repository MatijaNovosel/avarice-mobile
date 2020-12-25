import 'package:flutter/material.dart';
import 'services/change-service.dart';
import "models/financial-change.dart";
import "widgets/change-card.dart";
import "widgets/app-bar.dart";
import "widgets/drawer.dart";

void main() => runApp(MyApp());

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

class MyApp extends StatelessWidget {
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

  void _setData(List<FinancialChange> val) {
    setState(() {
      _financialChanges = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: CustomAppBar(),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _loading
                ? CircularProgressIndicator()
                : GestureDetector(
                    onTap: () async {
                      _setLoading(true);
                      List<FinancialChange> res = await function();
                      _setData(res);
                      _setLoading(false);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).buttonColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text('Get data'),
                    ),
                  ),
            Container(
                margin: EdgeInsets.all(12),
                child: Container(child: Text("Hello")))
          ]),
      drawer: CustomDrawer(),
    );
  }
}

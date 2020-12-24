import 'package:flutter/material.dart';
import 'services/change-service.dart';

void main() => runApp(MyApp());

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

class _MyHomepageState extends State<Home> {
  bool _loading = false;

  void _setLoading(bool val) {
    setState(() {
      _loading = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.grey[850],
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.ideographic,
          children: [
            Text('Finapp',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 138, 0))),
            Container(
                margin: EdgeInsets.only(left: 3.0),
                child: Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text('by Matija Novosel',
                        style:
                            TextStyle(fontSize: 13, color: Colors.grey[400])))),
            Spacer(),
            Container(
                margin: EdgeInsets.only(right: 15.0), child: Icon(Icons.logout))
          ],
        ),
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loading
                  ? CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () {
                        _setLoading(true);
                        function();
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
            ]),
      ),
      drawer: Drawer(
        child: Ink(
            color: Colors.grey[850],
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.only(right: 14),
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/images/zhu.jpg")))),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Matija Novosel",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 138, 0))),
                          Text("mnovosel5@gmail.com",
                              style: TextStyle(color: Colors.grey[400]))
                        ],
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.grey[600]),
                  title: Text('Pocetna stranica',
                      style: TextStyle(color: Colors.grey[400])),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ExpansionTile(
                  title: Text('Financijske akcije',
                      style: TextStyle(color: Colors.grey[400])),
                  backgroundColor: Colors.grey[900],
                  leading: Icon(Icons.attach_money, color: Colors.grey[600]),
                  children: [
                    ListTile(
                      leading:
                          Icon(Icons.remove_circle, color: Colors.red[700]),
                      title: Text('Novi trosak',
                          style: TextStyle(color: Colors.grey[400])),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.add_circle, color: Colors.green[700]),
                      title: Text('Novi dobitak',
                          style: TextStyle(color: Colors.grey[400])),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.grey[600]),
                  title: Text('Postavke',
                      style: TextStyle(color: Colors.grey[400])),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

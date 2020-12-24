import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'ProximaNova'),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
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
        child: Text(
          'Hello World',
          style: TextStyle(color: Colors.white),
        ),
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
                  leading: Icon(Icons.access_alarm),
                  title: Text('Pocetna stranica'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.access_alarm),
                  title: Text('Financijske akcije'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.access_alarm),
                  title: Text('Postavke'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )),
      ),
    );
  }
}

import 'package:finapp/views/accounts.dart';
import 'package:finapp/views/history.dart';
import 'package:finapp/views/dashboard.dart';
import 'package:finapp/views/login.dart';
import 'package:finapp/widgets/appBar.dart';
import 'package:finapp/widgets/drawer.dart';
import 'package:flutter/material.dart';
import "views/newEntry.dart";

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      Login(),
      Dashboard(),
      NewEntry(),
      History(),
      Accounts(),
    ];

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: CustomAppBar(),
        drawer: CustomDrawer(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                blurRadius: 0.5,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            selectedItemColor: Colors.orange,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.login),
                label: "Login",
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fiber_new),
                label: 'New entry',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_tree),
                label: 'Accounts',
              )
            ],
            onTap: _onItemTapped,
          ),
        ),
        body: _children.elementAt(_currentIndex),
      ),
    );
  }
}

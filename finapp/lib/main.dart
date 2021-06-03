import 'package:finapp/views/accounts.dart';
import 'package:finapp/views/history.dart';
import 'package:finapp/views/dashboard.dart';
import 'package:finapp/views/login.dart';
import 'package:finapp/widgets/appBar.dart';
import 'package:finapp/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/newTransaction.dart';
import 'package:jwt_decode/jwt_decode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("bearerToken");

  var tokenValid = true;

  if (token != null) {
    Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
    var tokenExp = decodedToken["exp"] * 1000;
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime > tokenExp) tokenValid = false;
  } else {
    tokenValid = false;
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
    themeMode: ThemeMode.dark,
    home: tokenValid ? MainScreen() : Login(),
  ));
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
      Dashboard(),
      NewEntry(),
      History(),
      Accounts(),
    ];

    return Scaffold(
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
              icon: new Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fiber_new),
              label: 'New transaction',
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
    );
  }
}

import 'package:finapp/views/accounts.dart';
import 'package:finapp/views/chartData.dart';
import 'package:finapp/views/history.dart';
import 'package:finapp/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("bearerToken");
    var tokenValid = true;

    if (token != null) {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      var tokenExp = decodedToken["exp"] * 1000;
      var currentTime = DateTime.now().millisecondsSinceEpoch;
      if (currentTime > tokenExp) tokenValid = false;
      prefs.remove("bearerToekn");
    } else {
      tokenValid = false;
    }

  */

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.black),
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      // home: tokenValid ? MainScreen() : Login(),
      home: MainScreen(),
    ),
  );
}

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      Dashboard(),
      History(),
      ChartData(),
      Accounts(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 25,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            iconSize: 25,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.logout_sharp),
            iconSize: 25,
            onPressed: () {},
          ),
        ],
        title: Text(
          "FinApp",
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 227, 229, 232),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 6,
            ),
            child: GNav(
              gap: 8,
              activeColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 227, 229, 232),
              iconSize: 24,
              textStyle: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              duration: Duration(
                milliseconds: 400,
              ),
              tabBackgroundColor: Color.fromARGB(255, 212, 212, 220),
              color: Colors.white,
              tabs: [
                GButton(
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                ),
                GButton(
                  icon: Icons.history,
                  text: 'History',
                ),
                GButton(
                  icon: Icons.bar_chart,
                  text: 'Data',
                ),
                GButton(
                  icon: Icons.account_balance_wallet,
                  text: 'Accounts',
                ),
              ],
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                if (index != _currentIndex) {
                  setState(() {
                    _currentIndex = index;
                  });
                }
              },
            ),
          ),
        ),
      ),
      body: Padding(
        child: _children[_currentIndex],
        padding: EdgeInsets.only(
          top: 12,
        ),
      ),
    );
  }
}

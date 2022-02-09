import 'package:finapp/views/accounts.dart';
import 'package:finapp/views/chartData.dart';
import 'package:finapp/views/history.dart';
import 'package:finapp/views/dashboard.dart';
// import 'package:finapp/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_offline/flutter_offline.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:jwt_decode/jwt_decode.dart';

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
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF081B33),
      ),
      themeMode: ThemeMode.dark,
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
        toolbarHeight: 105,
        backgroundColor: Color(0x121212),
        elevation: 0.0,
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
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FinApp",
                  style: TextStyle(
                    fontSize: 38,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                  ),
                  child: Text(
                    "Welcome back Matija Novosel!",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF152642),
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
              backgroundColor: Color(0xFF152642),
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
              tabBackgroundColor: Color(0xFF081B33),
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
      body: _children[_currentIndex],
    );
  }
}

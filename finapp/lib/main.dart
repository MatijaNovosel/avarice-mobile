import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:finapp/views/accounts.dart';
import 'package:finapp/views/history.dart';
import 'package:finapp/views/dashboard.dart';
import 'package:finapp/views/login.dart';
import 'package:finapp/widgets/appBar.dart';
import 'package:finapp/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
    prefs.remove("bearerToekn");
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
          color: Colors.grey[850],
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.2),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8,
            ),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 8,
              activeColor: Colors.white,
              iconSize: 20,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              duration: Duration(
                milliseconds: 400,
              ),
              tabBackgroundColor: Colors.grey[900],
              color: Colors.grey[600],
              tabs: [
                GButton(
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                ),
                GButton(
                  icon: Icons.new_label,
                  text: 'New transaction',
                ),
                GButton(
                  icon: Icons.history,
                  text: 'History',
                ),
                GButton(
                  icon: Icons.account_balance_wallet,
                  text: 'Accounts',
                ),
              ],
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      body: _children.elementAt(_currentIndex),
    );
  }
}

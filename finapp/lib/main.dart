import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finapp/views/accounts.dart';
import 'package:finapp/views/history.dart';
import 'package:finapp/views/home.dart';
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
  final GlobalKey _bottomNavigationKey = GlobalKey();
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    final List<Widget> _children = [
      Home(),
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
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: currentIndex,
          height: 55,
          items: <Widget>[
            Icon(Icons.home, size: 25),
            Icon(Icons.create_rounded, size: 25),
            Icon(Icons.history, size: 25),
            Icon(Icons.credit_card_outlined, size: 25),
          ],
          color: Colors.grey[800],
          backgroundColor: Colors.grey[850],
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
            _pageController.animateToPage(
              currentIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
        ),
        body: PageView(
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
              final CurvedNavigationBarState navBarState =
                  _bottomNavigationKey.currentState;
              navBarState.setPage(currentIndex);
            });
          },
          controller: _pageController,
          children: _children,
        ),
      ),
    );
  }
}

import 'package:finapp/popupTemplates/newTransaction.dart';
import 'package:finapp/popupTemplates/newTransfer.dart';
import 'package:finapp/views/accounts.dart';
import 'package:finapp/views/chartData.dart';
import 'package:finapp/views/history.dart';
import 'package:finapp/views/dashboard.dart';
import 'package:finapp/views/login.dart';
import 'package:finapp/widgets/appBar.dart';
import 'package:finapp/widgets/drawer.dart';
import 'package:finapp/widgets/forms/transactionForm.dart';
import 'package:finapp/widgets/forms/transferForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import 'controllers/formSubmitController.dart';

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

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.black),
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
      primarySwatch: Colors.orange,
    ),
    home: tokenValid ? MainScreen() : Login(),
  ));
}

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final FormSubmitController _formSubmitController = new FormSubmitController();
  int _currentIndex = 0;

  void _openTransactionPopup() {
    final popup = BeautifulPopup.customize(
      context: context,
      build: (options) => NewTransactionPopup(options),
    );
    popup.show(
      title: 'New transaction',
      content: Container(
        child: TransactionForm(
          controller: _formSubmitController,
        ),
      ),
      actions: [
        ConfirmationSlider(
          height: 50,
          foregroundColor: Colors.orange,
          onConfirmation: () {
            _formSubmitController.submit();
          },
        ),
      ],
    );
  }

  void _openTransferPopup() {
    final popup = BeautifulPopup.customize(
      context: context,
      build: (options) => NewTransferPopup(options),
    );
    popup.show(
      title: 'New transfer',
      content: Container(
        child: TransferForm(
          controller: _formSubmitController,
        ),
      ),
      actions: [
        ConfirmationSlider(
          height: 50,
          foregroundColor: Colors.orange,
          onConfirmation: () {
            _formSubmitController.submit();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      Dashboard(),
      History(),
      ChartData(),
      Accounts(),
    ];

    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(
        onTransactionPopup: _openTransactionPopup,
        onTransferPopup: _openTransferPopup,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
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
              activeColor: Colors.orange,
              iconSize: 24,
              textStyle: TextStyle(
                fontSize: 16,
                color: Colors.orange,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              duration: Duration(
                milliseconds: 400,
              ),
              tabBackgroundColor: Colors.grey[200],
              color: Colors.grey[600],
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
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return _children[_currentIndex];
          } else {
            return new Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  height: 44.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    color: Colors.red[800],
                    child: Center(
                      child: Text(
                        "You are offline.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: new Text(
                    'Please connect to the internet.',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            );
          }
        },
        child: Container(),
      ),
    );
  }
}

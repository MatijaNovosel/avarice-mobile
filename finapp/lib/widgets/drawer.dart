import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/views/login.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef OpenTransactionPopupCallback = void Function();
typedef OpenTransferPopupCallback = void Function();

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({this.onTransferPopup, this.onTransactionPopup});
  final OpenTransferPopupCallback onTransferPopup;
  final OpenTransactionPopupCallback onTransactionPopup;

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String _username;
  String _email;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.get("username");
      _email = prefs.get("email");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Ink(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(
                      right: 14,
                    ),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/zhu.jpg"),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _username == null ? "" : _username,
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 138, 0),
                        ),
                      ),
                      Text(
                        _email == null ? "" : _email,
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.sync_alt,
                color: Colors.grey[600],
              ),
              title: Text(
                'New transfer',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                widget.onTransferPopup();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.attach_money,
                color: Colors.grey[600],
              ),
              title: Text(
                'New transaction',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                widget.onTransactionPopup();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[600],
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.grey[600],
              ),
              title: Text(
                'Log out',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.remove("bearerToken");

                showAlert(context, "Signed out!", false);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

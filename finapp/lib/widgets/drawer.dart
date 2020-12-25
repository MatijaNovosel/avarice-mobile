import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    leading: Icon(Icons.remove_circle, color: Colors.red[700]),
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
                title:
                    Text('Postavke', style: TextStyle(color: Colors.grey[400])),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import "../widgets/app-bar.dart";
import "../widgets/drawer.dart";

class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20,
                ),
                child: Text(
                  "New entry",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.description),
                hintText: 'Entry description',
                labelText: 'Description *',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  //
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
      drawer: CustomDrawer(),
    );
  }
}

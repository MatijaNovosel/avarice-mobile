import 'package:flutter/material.dart';

class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.grey[850],
        title: Text(
          'New entry',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: <Color>[
                  Color.fromARGB(255, 255, 138, 0),
                  Color.fromARGB(255, 229, 46, 113)
                ],
              ).createShader(
                Rect.fromLTWH(40.0, 0.0, 80.0, 200.0),
              ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        child: Column(
          children: [
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
    );
  }
}

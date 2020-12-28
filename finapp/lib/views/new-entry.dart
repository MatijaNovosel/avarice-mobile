import 'package:finapp/constants/tag-enum.dart';
import 'package:finapp/helpers/helpers.dart';
import 'package:flutter/material.dart';

class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  List<bool> _checkboxValues = List.filled(TagEnum.keys.length, false);

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
                  Color.fromARGB(255, 229, 46, 113),
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: TagEnum.keys.length,
              itemBuilder: (context, i) {
                return CheckboxListTile(
                  value: _checkboxValues[i],
                  onChanged: (bool val) {
                    setState(() {
                      _checkboxValues[i] = !_checkboxValues[i];
                    });
                  },
                  title: Text(
                    parseTag(TagEnum.keys.elementAt(i)),
                  ),
                  secondary: Icon(
                    parseTagIcon(TagEnum.keys.elementAt(i)),
                    color: Colors.grey[350],
                  ),
                  activeColor: Colors.blue,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 48,
        width: 48,
        child: FloatingActionButton(
          onPressed: () {
            //
          },
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: Icon(
            Icons.save,
          ),
        ),
      ),
    );
  }
}

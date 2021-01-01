import 'package:finapp/widgets/forms/expense-form.dart';
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
          top: 12,
        ),
        child: ExpenseForm(),
        /*SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey[350],
                  ),
                ),
                constraints: BoxConstraints(
                  maxHeight: 300,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: TagEnum.keys.length,
                  itemBuilder: (context, i) {
                    return CheckboxListTile(
                      value: _checkboxValues[i],
                      onChanged: (bool val) {
                        setState(() {
                          _checkboxValues[i] = !_checkboxValues[i];
                          if (val)
                            _selectedTags.add(
                              TagEnum.keys.elementAt(
                                i,
                              ),
                            );
                          else
                            _selectedTags.remove(
                              TagEnum.keys.elementAt(i),
                            );
                        });
                      },
                      title: Text(
                        parseTag(
                          TagEnum.keys.elementAt(i),
                        ),
                      ),
                      secondary: Icon(
                        parseTagIcon(
                          TagEnum.keys.elementAt(i),
                        ),
                        color: Colors.grey[350],
                      ),
                      activeColor: Colors.orange,
                    );
                  },
                ),
              ),
            ],
          ),
        ),*/
      ),
    );
  }
}

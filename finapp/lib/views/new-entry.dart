import 'package:finapp/constants/tag-enum.dart';
import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/payment-source.dart';
import 'package:finapp/services/financial-history-service.dart';
import 'package:finapp/widgets/current-amount-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  List<bool> _checkboxValues = List.filled(TagEnum.keys.length, false);
  List<int> _selectedTags = [];
  bool _expense = false;
  final Future<List<PaymentSource>> _paymentSources = getCurrentAmount();
  int _index = 0;
  int _selectedPaymentSource = 0;

  void createFinancialChange() {
    print(_selectedTags);
    print(_expense);
    print(_selectedPaymentSource);
  }

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
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: Icon(
                  Icons.description_rounded,
                  color: Colors.grey[350],
                ),
              ),
              title: TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[350],
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[350],
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[350],
                    ),
                  ),
                  hintText: "Entry description",
                  isDense: true,
                  labelText: "Description",
                  focusColor: Colors.grey[350],
                  fillColor: Colors.grey[350],
                  hoverColor: Colors.grey[350],
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    color: Colors.grey[350],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: Icon(
                  Icons.attach_money_rounded,
                  color: Colors.grey[350],
                ),
              ),
              title: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffix: Text("HRK"),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[350],
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[350],
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[350],
                    ),
                  ),
                  hintText: "Entry amount",
                  isDense: true,
                  labelText: "Amount",
                  focusColor: Colors.grey[350],
                  fillColor: Colors.grey[350],
                  hoverColor: Colors.grey[350],
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    color: Colors.grey[350],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 6,
                bottom: 6,
              ),
              child: SwitchListTile(
                title: const Text('Expense'),
                value: _expense,
                activeColor: Colors.orange,
                onChanged: (bool value) {
                  setState(() {
                    _expense = !_expense;
                  });
                },
                secondary: const Icon(
                  Icons.done_all_rounded,
                ),
              ),
            ),
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
            FutureBuilder<List<PaymentSource>>(
              future: _paymentSources,
              builder: (
                BuildContext context,
                AsyncSnapshot<List<PaymentSource>> snapshot,
              ) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    {
                      return Center(
                        child: SpinKitThreeBounce(
                          color: Colors.red,
                          size: 50.0,
                        ),
                      );
                    }
                  default:
                    {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return SizedBox(
                          height: 100,
                          child: PageView.builder(
                            itemCount: snapshot.data.length,
                            onPageChanged: (int index) => setState(
                              () {
                                _index = index;
                                _selectedPaymentSource = index;
                              },
                            ),
                            itemBuilder: (_, i) {
                              return Transform.scale(
                                scale: i == _index ? 1 : 0.9,
                                child: CurrentAmountCardWidget(
                                  icon: Icons.account_balance_wallet,
                                  color: Colors.orange[600],
                                  paymentSource: snapshot.data[i],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                }
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
            createFinancialChange();
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

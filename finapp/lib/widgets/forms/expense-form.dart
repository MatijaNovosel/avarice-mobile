import 'package:finapp/constants/tag-enum.dart';
import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/widgets/current-amount-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  bool _expense = true;
  int _paymentSourceId = 0;
  List<int> _selectedTags = [];
  List<bool> _checkboxValues = List.filled(TagEnum.keys.length, false);

  void submitForm() {
    if (_formKey.currentState.validate()) {
      var payload = {
        "amount": _amountController.text,
        "description": _descriptionController.text,
        "expense": _expense,
        "paymentSourceId": _paymentSourceId,
      };

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: SpinKitFoldingCube(
                color: Colors.red,
                size: 65,
              ),
            ),
          );
        },
      );
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    } else {
      var snackBar = SnackBar(
        content: Text(
          'Invalid data supplied!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[800],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CurrentAmountListWidget(
              onPaymentSourceChanged: (id) {
                setState(() {
                  _paymentSourceId = id;
                });
              },
            ),
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
              title: TextFormField(
                controller: _descriptionController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[350]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[350]),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[350]),
                  ),
                  hintText: "Entry description",
                  isDense: true,
                  labelText: "Description",
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(color: Colors.grey[350]),
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
              title: TextFormField(
                controller: _amountController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required!';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffix: Text("HRK"),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[350]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[350]),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[350]),
                  ),
                  hintText: "Entry amount",
                  isDense: true,
                  labelText: "Amount",
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    color: Colors.grey[350],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
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
            SingleChildScrollView(
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
                                _selectedTags.add(TagEnum.keys.elementAt(i));
                              else
                                _selectedTags.remove(TagEnum.keys.elementAt(i));
                            });
                          },
                          title: Text(
                            parseTag(TagEnum.keys.elementAt(i)),
                          ),
                          secondary: Icon(
                            parseTagIcon(TagEnum.keys.elementAt(i)),
                            color: Colors.grey[350],
                          ),
                          activeColor: Colors.orange,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: TextButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: submitForm,
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

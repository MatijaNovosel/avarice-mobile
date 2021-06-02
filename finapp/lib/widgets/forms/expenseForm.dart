import 'package:finapp/controllers/formSubmitController.dart';
import 'package:finapp/widgets/currentAmountList.dart';
import 'package:finapp/widgets/tagCheckboxList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ExpenseForm extends StatefulWidget {
  final FormSubmitController controller;
  ExpenseForm({this.controller});

  @override
  _ExpenseFormState createState() => _ExpenseFormState(controller);
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  bool _expense = true;
  bool _tagsValid = false;
  int _paymentSourceId = 0;
  List<int> _selectedTags = [];
  final FormSubmitController formSubmitController = FormSubmitController();

  _ExpenseFormState(FormSubmitController _controller) {
    _controller.submit = submit;
  }

  void submitForm() {
    if (_formKey.currentState.validate() && _tagsValid) {
      var payload = {
        "amount": _amountController.text,
        "description": _descriptionController.text,
        "expense": _expense,
        "paymentSourceId": _paymentSourceId,
        "tagIds": _selectedTags,
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

  void submit() {
    /*

      TODO: Controller for the tag checklist, they have the same name.
      Change later.
    
    */
    submitForm();
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
              onAccountChange: (id) {
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
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: Icon(
                  Icons.label,
                  color: Colors.grey[350],
                ),
              ),
              title: DropdownButton<String>(
                hint: Text("Tags"),
                isExpanded: true,
                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
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
            ElevatedButton(
              onPressed: () {},
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}

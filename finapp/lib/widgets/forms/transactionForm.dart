import 'package:finapp/controllers/formSubmitController.dart';
import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/transaction.dart';
import 'package:finapp/services/tagService.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:finapp/widgets/currentAmountList.dart';
import 'package:finapp/widgets/multiSelectDialog.dart';
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
  int _accountId = 1;
  List<int> _selectedTags = [];
  final FormSubmitController formSubmitController = FormSubmitController();

  _ExpenseFormState(FormSubmitController _controller) {
    _controller.submit = submit;
  }

  void submitForm() async {
    if (_formKey.currentState.validate()) {
      if (_selectedTags.length == 0) {
        showAlert(context, "No tags selected!", true, "top");
        return;
      }

      NewTransaction payload = new NewTransaction(
        amount: double.parse(_amountController.text),
        description: _descriptionController.text,
        expense: _expense,
        accountId: _accountId,
        tags: _selectedTags,
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              content: SpinKitFoldingCube(
                color: Colors.white,
                size: 65,
              ),
            ),
          );
        },
      );

      try {
        await addTransaction(payload);
        showAlert(context, "Transaction added", false, "top");
      } catch (e) {
        showAlert(context, "Error adding transaction", true, "top");
      } finally {
        Navigator.pop(context);
      }
    } else {
      showAlert(context, "Invalid data", true, "top");
    }
  }

  void _showMultiSelect(BuildContext context) async {
    var tags = await getTags();
    var selectItems = tags
        .map(
          (e) => new MultiSelectDialogItem(
            e.id,
            e.description,
          ),
        )
        .toList();

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: selectItems,
          title: "Select tags",
          initialSelectedValues: _selectedTags.toSet(),
        );
      },
    );

    if (selectedValues != null) {
      setState(() {
        _selectedTags = selectedValues.toList();
      });
    }
  }

  void submit() {
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CurrentAmountListWidget(
              onAccountChange: (id) {
                setState(() {
                  _accountId = id;
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
            Container(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () {
                  _showMultiSelect(context);
                },
                child: Text('Select tags'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  submit();
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:finapp/controllers/formSubmitController.dart';
import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/newTransaction/newTransaction.dart';
import 'package:finapp/services/tagService.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:finapp/widgets/currentAmountList.dart';
import 'package:finapp/widgets/multiSelectDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TransactionForm extends StatefulWidget {
  final FormSubmitController controller;
  TransactionForm({required this.controller});

  @override
  _TransactionFormState createState() => _TransactionFormState(controller);
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  bool _loading = false;
  bool _expense = true;
  int _accountId = 1;
  List<int> _selectedTags = [];
  final FormSubmitController formSubmitController = FormSubmitController();

  _TransactionFormState(FormSubmitController _controller) {
    _controller.submit = submit;
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedTags.length == 0) {
        showAlert(context, "No tags selected!", true);
        return;
      }

      setState(() {
        _loading = true;
      });

      NewTransaction payload = new NewTransaction(
        amount: double.parse(_amountController.text),
        description: _descriptionController.text,
        expense: _expense,
        accountId: _accountId,
        tags: _selectedTags,
      );

      try {
        await addTransaction(payload);
        showAlert(context, "Transaction added", false);
        Navigator.pop(context);
      } catch (e) {
        showAlert(context, "Error adding transaction", true);
      } finally {
        setState(() {
          _loading = false;
        });
      }
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
        child: _loading
            ? Center(
                child: SpinKitFoldingCube(
                  color: Colors.orange,
                  size: 50.0,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        color: Colors.grey[600],
                      ),
                    ),
                    title: TextFormField(
                      controller: _descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field is required!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[600] as Color),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[600] as Color),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[600] as Color),
                        ),
                        hintText: "Entry description",
                        isDense: true,
                        labelText: "Description",
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(color: Colors.grey[600]),
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
                        color: Colors.grey[600],
                      ),
                    ),
                    title: TextFormField(
                      controller: _amountController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field is required!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffix: Text("HRK"),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[600] as Color),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[600] as Color),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[600] as Color),
                        ),
                        hintText: "Entry amount",
                        isDense: true,
                        labelText: "Amount",
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
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
                        foregroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        _showMultiSelect(context);
                      },
                      child: Text('Select tags'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

import 'package:finapp/controllers/formSubmitController.dart';
import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/transaction.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:finapp/widgets/currentAmountList.dart';
import 'package:flutter/material.dart';

class TransferForm extends StatefulWidget {
  final FormSubmitController controller;
  TransferForm({this.controller});

  @override
  _TransferFormState createState() => _TransferFormState(controller);
}

class _TransferFormState extends State<TransferForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  int _accountFromId = 1;
  int _accountToId = 2;
  final FormSubmitController formSubmitController = FormSubmitController();

  _TransferFormState(FormSubmitController _controller) {
    _controller.submit = submit;
  }

  void submitForm() async {
    if (_formKey.currentState.validate()) {
      NewTransfer payload = new NewTransfer(
          amount: double.parse(_amountController.text),
          accountToId: _accountFromId,
          accountFromId: _accountToId);

      try {
        await addTransfer(payload);
        showAlert(context, "Transfer added", false, "top");
        Navigator.pop(context);
      } catch (e) {
        showAlert(context, "Error adding transfer", true, "top");
      }
    } else {
      showAlert(context, "Invalid data", true, "top");
    }
  }

  void submit() {
    submitForm();
  }

  @override
  void dispose() {
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
                  _accountFromId = id;
                });
              },
            ),
            CurrentAmountListWidget(
              onAccountChange: (id) {
                setState(() {
                  _accountToId = id;
                });
              },
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
                  if (value.isEmpty) {
                    return 'This field is required!';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffix: Text("HRK"),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[600]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[600]),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[600]),
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
          ],
        ),
      ),
    );
  }
}

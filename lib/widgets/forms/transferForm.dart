import 'package:finapp/controllers/formSubmitController.dart';
import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/newTransfer/newTransfer.dart';
import 'package:finapp/services/transactionService.dart';
import 'package:finapp/widgets/currentAmountList.dart';
import 'package:flutter/material.dart';

class TransferForm extends StatefulWidget {
  final FormSubmitController controller;
  TransferForm({required this.controller});

  @override
  _TransferFormState createState() => _TransferFormState(controller);
}

class _TransferFormState extends State<TransferForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  int _accountFromId = 1;
  int _accountToId = 1;
  final FormSubmitController formSubmitController = FormSubmitController();

  _TransferFormState(FormSubmitController _controller) {
    _controller.submit = submit;
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_accountFromId == _accountToId) {
        showAlert(context, "Accounts must not be the same!", true);
        return;
      }

      NewTransfer payload = new NewTransfer(
        amount: double.parse(_amountController.text),
        accountToId: _accountToId,
        accountFromId: _accountFromId,
      );

      try {
        await addTransfer(payload);
        showAlert(context, "Transfer added", false);
        Navigator.pop(context);
      } catch (e) {
        showAlert(context, "Error adding transfer", true);
      }
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Account from",
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CurrentAmountListWidget(
                onAccountChange: (id) {
                  setState(() {
                    _accountFromId = id;
                  });
                },
              ),
            ),
            Text(
              "Account to",
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CurrentAmountListWidget(
                onAccountChange: (id) {
                  setState(() {
                    _accountToId = id;
                  });
                },
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
          ],
        ),
      ),
    );
  }
}

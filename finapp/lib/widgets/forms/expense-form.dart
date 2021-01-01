import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  @override
  ExpenseFormState createState() {
    return ExpenseFormState();
  }
}

class ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  print(_descriptionController.text);
                  if (_formKey.currentState.validate()) {
                    print("Valid!");
                  } else {
                    print("Invalid!");
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

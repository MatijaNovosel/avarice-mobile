import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showAlert(context, String msg, bool error, String position) {
  Flushbar(
    flushbarPosition:
        position == "top" ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
    margin: EdgeInsets.all(8),
    borderRadius: 6,
    backgroundColor: error ? Colors.red[800] : Colors.green,
    message: msg,
    duration: Duration(seconds: 3),
    icon: Icon(
      error ? Icons.error : Icons.check,
      color: Colors.white,
    ),
  )..show(context);
}

String formatHrk(double amount) {
  return "${NumberFormat("#,##0.00", "hr_HR").format(amount)} HRK";
}

String formatDateToCroatian(String date) {
  return "${DateFormat("dd.MM.yyyy. HH:mm:ss").format(DateTime.parse(date))}";
}

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

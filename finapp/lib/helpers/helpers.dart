import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showAlert(context, String msg, bool error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
          Text(msg),
        ],
      ),
      backgroundColor: error ? Colors.red : Colors.green,
      duration: const Duration(milliseconds: 4500),
      elevation: 1000000000000,
      margin: const EdgeInsets.all(
        8.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}

String formatHrk(double amount) {
  return "${NumberFormat("#,##0.00", "hr_HR").format(amount)} HRK";
}

String formatDateToCroatian(String date) {
  return "${DateFormat("dd.MM.yyyy. HH:mm:ss").format(DateTime.parse(date))}";
}

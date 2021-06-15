import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'dart:ui';

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

Color randomColor() {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}

double log10(num x) => log(x) / ln10;

List<dynamic> makeYAxis(double yMin, double yMax, {int ticks = 10}) {
  var yMinTemp = yMin;
  var yMaxTemp = yMax;
  var ticksTemp = ticks;

  var result = [];

  if (yMinTemp == yMaxTemp) {
    yMinTemp -= ticksTemp;
    yMaxTemp += ticksTemp;
  }
  var range = yMaxTemp - yMinTemp;
  if (ticksTemp < 2) {
    ticksTemp = 2;
  } else if (ticksTemp > 2) {
    ticksTemp -= 2;
  }

  var tempStep = range / ticksTemp;

  var mag = log10(tempStep).floor();
  var magPow = pow(10, mag);
  var magMsd = tempStep / magPow + 0.5;
  var stepSize = magMsd * magPow;

  var lb = stepSize * yMinTemp / stepSize;
  var ub = stepSize * (yMaxTemp / stepSize).ceil();

  var val = lb;

  while (true) {
    result.add(val);
    val += stepSize;
    if (val > ub) {
      break;
    }
  }

  return result;
}

double getYAxisInterval(double yMin, double yMax, {int ticks = 10}) {
  var yMinTemp = yMin;
  var yMaxTemp = yMax;
  var ticksTemp = ticks;

  var result = [];

  if (yMinTemp == yMaxTemp) {
    yMinTemp -= ticksTemp;
    yMaxTemp += ticksTemp;
  }
  var range = yMaxTemp - yMinTemp;
  if (ticksTemp < 2) {
    ticksTemp = 2;
  } else if (ticksTemp > 2) {
    ticksTemp -= 2;
  }

  var tempStep = range / ticksTemp;

  var mag = log10(tempStep).floor();
  var magPow = pow(10, mag);
  var magMsd = tempStep / magPow + 0.5;
  var stepSize = magMsd * magPow;

  var lb = stepSize * yMinTemp / stepSize;
  var ub = stepSize * (yMaxTemp / stepSize).ceil();

  var val = lb;

  while (true) {
    result.add(val);
    val += stepSize;
    if (val > ub) {
      break;
    }
  }

  return result[1] - result[0];
}

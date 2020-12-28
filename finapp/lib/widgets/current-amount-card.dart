import 'package:finapp/models/paymentSource.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _CurrentAmountCardState extends State<CurrentAmountCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[850],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: widget.color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            child: Icon(
              widget.icon,
              color: widget.color,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.paymentSource.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[300],
                  ),
                ),
                Text(
                  "${NumberFormat("#,##0.00", "hr_HR").format(widget.paymentSource.amount)} HRK",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurrentAmountCardWidget extends StatefulWidget {
  final PaymentSource paymentSource;
  final bool visible;
  final Color color;
  final IconData icon;
  const CurrentAmountCardWidget({
    Key key,
    this.paymentSource,
    this.visible,
    this.color,
    this.icon,
  }) : super(key: key);
  @override
  _CurrentAmountCardState createState() => _CurrentAmountCardState();
}

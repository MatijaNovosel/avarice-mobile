import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/transaction.dart';
import 'package:flutter/material.dart';
import "tag.dart";

class TransactionCardWidget extends StatefulWidget {
  final Transaction transaction;
  final bool visible;

  const TransactionCardWidget({
    Key key,
    this.transaction,
    this.visible,
  }) : super(key: key);

  @override
  _ChangeCardState createState() => _ChangeCardState();
}

class _ChangeCardState extends State<TransactionCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey[900],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.transaction.description,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                  ),
                  child: Text(
                    widget.transaction.createdAt,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.visible
                  ? formatHrk(widget.transaction.amount)
                  : "${widget.transaction.amount.toStringAsFixed(2)} HRK".replaceAll(new RegExp(r'[0-9]'), '*'),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: widget.transaction.expense == true ? Colors.white : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

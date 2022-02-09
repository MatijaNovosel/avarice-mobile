import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/transaction.dart';
import 'package:flutter/material.dart';

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
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 0,
          right: 24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 14.0,
                  ),
                  child: Container(
                    child: Icon(([
                      Icons.ac_unit,
                      Icons.hdr_on,
                      Icons.account_balance_rounded,
                      Icons.add_alarm_rounded,
                      Icons.add_box_sharp,
                    ].toList()
                          ..shuffle())
                        .first),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF2F4562),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.transaction.description,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey[300],
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
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              widget.visible
                  ? formatHrk(widget.transaction.amount)
                  : "${widget.transaction.amount.toStringAsFixed(2)} HRK".replaceAll(new RegExp(r'[0-9]'), '*'),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.transaction.expense == true ? Colors.white : Colors.green[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

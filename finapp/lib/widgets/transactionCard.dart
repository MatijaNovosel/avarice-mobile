import 'package:finapp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "tag.dart";

class _ChangeCardState extends State<TransactionCardWidget> {
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.transaction.description} • ${DateFormat("dd.MM.yyyy. HH:mm:ss").format(DateTime.parse(widget.transaction.createdAt))}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[300],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 8),
                    child: Text(
                      widget.visible
                          ? "${NumberFormat("#,##0.00", "hr_HR").format(widget.transaction.amount)} HRK"
                          : "${widget.transaction.amount.toStringAsFixed(2)} HRK"
                              .replaceAll(new RegExp(r'[0-9]'), '*'),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for (var tag in widget.transaction.tags)
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TagWidget(
                            text: tag.description,
                            color: widget.transaction.expense == true
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionCardWidget extends StatefulWidget {
  final Transaction transaction;
  final bool visible;
  const TransactionCardWidget({Key key, this.transaction, this.visible})
      : super(key: key);
  @override
  _ChangeCardState createState() => _ChangeCardState();
}

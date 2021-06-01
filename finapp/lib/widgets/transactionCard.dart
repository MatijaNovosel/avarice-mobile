import 'package:finapp/models/transaction.dart';
import 'package:flutter/material.dart';
import "tag.dart";

class _ChangeCardState extends State<TransactionCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.transaction.expense ? Colors.red[800] : Colors.green[800],
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
              color: widget.transaction.expense ? Colors.red : Colors.green,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.transaction.description} • ${widget.transaction.createdAt}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[300],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 8),
                    child: Text(
                      widget.visible
                          ? "${widget.transaction.amount} HRK"
                          : "${widget.transaction.amount} HRK"
                              .replaceAll(new RegExp(r'[0-9]'), '*'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for (var id in widget.transaction.tagIds)
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TagWidget(
                            text: "Text",
                            color: widget.transaction.expense
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

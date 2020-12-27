import 'package:finapp/models/financial-change.dart';
import 'package:flutter/material.dart';

class _ChangeCardState extends State<ChangeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.financialChange.expense
            ? Colors.red[800]
            : Colors.green[800],
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
              color: widget.financialChange.expense ? Colors.red : Colors.green,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.financialChange.description} • ${widget.financialChange.createdAt}",
                  style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    widget.visible
                        ? "${widget.financialChange.amount} HRK"
                        : "${widget.financialChange.amount} HRK"
                            .replaceAll(new RegExp(r'[0-9]'), '*'),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

class ChangeCardWidget extends StatefulWidget {
  final FinancialChange financialChange;
  final bool visible;
  const ChangeCardWidget({Key key, this.financialChange, this.visible})
      : super(key: key);
  @override
  _ChangeCardState createState() => _ChangeCardState();
}

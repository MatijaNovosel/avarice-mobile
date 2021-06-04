import 'package:finapp/models/account.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _CurrentAmountCardState extends State<CurrentAmountCardWidget> {
  bool _visible = false;

  @override
  void initState() {
    setState(() {
      _visible =
          widget.showInitialValue != null ? widget.showInitialValue : false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Card(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 12.0,
              ),
              child: Icon(
                widget.icon,
                color: Colors.grey[400],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      widget.account.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  Text(
                    _visible
                        ? "${NumberFormat("#,##0.00", "hr_HR").format(widget.account.amount)} HRK"
                        : "${widget.account.amount.toStringAsFixed(2)} HRK"
                            .replaceAll(new RegExp(r'[0-9]'), '*'),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: widget.color,
                    ),
                  ),
                ],
              ),
            ),
            widget.showHideButton == false
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                      right: 24.0,
                    ),
                    child: IconButton(
                      icon: _visible
                          ? Icon(Icons.stop_circle)
                          : Icon(Icons.panorama_fish_eye),
                      color: Colors.grey[400],
                      onPressed: () {
                        setState(() {
                          _visible = !_visible;
                        });
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class CurrentAmountCardWidget extends StatefulWidget {
  final Account account;
  final Color color;
  final IconData icon;
  final bool showHideButton;
  final bool showInitialValue;

  const CurrentAmountCardWidget({
    Key key,
    this.account,
    this.color,
    this.icon,
    this.showHideButton,
    this.showInitialValue,
  }) : super(key: key);

  @override
  _CurrentAmountCardState createState() => _CurrentAmountCardState();
}

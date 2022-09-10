import 'package:finapp/helpers/helpers.dart';
import 'package:finapp/models/account.dart';
import 'package:flutter/material.dart';

class CurrentAmountCard extends StatefulWidget {
  final Account account;
  final bool showInitialValue;
  final bool? showHideButton;
  final bool? gradient;
  final Color? color;
  final IconData? icon;
  final Color? gradientFrom;
  final Color? gradientTo;
  final Color? mainTextColor;
  final double? height;
  final double? width;
  final double? margin;

  CurrentAmountCard({
    Key? key,
    required this.account,
    required this.showInitialValue,
    this.showHideButton,
    this.mainTextColor,
    this.color,
    this.width,
    this.margin,
    this.icon,
    this.gradient,
    this.gradientFrom,
    this.gradientTo,
    this.height,
  }) : super(key: key);

  @override
  _CurrentAmountCardState createState() => _CurrentAmountCardState();
}

class _CurrentAmountCardState extends State<CurrentAmountCard> {
  bool _visible = false;

  @override
  void initState() {
    setState(() {
      _visible = widget.showInitialValue ? widget.showInitialValue : false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        width: widget.width ?? 150,
        height: widget.height ?? 55,
        margin: EdgeInsets.symmetric(
          horizontal: widget.margin ?? 0,
        ),
        decoration: BoxDecoration(
          gradient: widget.gradient != null
              ? widget.gradient!
                  ? LinearGradient(
                      colors: [
                        widget.gradientFrom!,
                        widget.gradientTo!,
                      ],
                    )
                  : null
              : null,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: <Widget>[
            widget.icon != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 12.0,
                    ),
                    child: Icon(
                      widget.icon ?? Icons.account_balance,
                      color: Colors.black,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      left: 16,
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    _visible
                        ? formatHrk(widget.account.amount)
                        : "${widget.account.amount.toStringAsFixed(2)} HRK".replaceAll(new RegExp(r'[0-9]'), '*'),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: widget.mainTextColor ?? Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            widget.showHideButton == false
                ? Padding(
                    padding: const EdgeInsets.only(
                      right: 24.0,
                    ),
                    child: IconButton(
                      icon: _visible ? Icon(Icons.circle) : Icon(Icons.panorama_fish_eye),
                      color: Colors.black,
                      onPressed: () {
                        setState(
                          () {
                            _visible = !_visible;
                          },
                        );
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

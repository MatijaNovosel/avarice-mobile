import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';

class NewTransactionPopup extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  NewTransactionPopup(this.options) : super(options);

  @override
  final illustrationKey = 'assets/images/empty.png';

  @override
  Color get primaryColor => options.primaryColor ?? Colors.orange;

  @override
  final maxWidth = 400;

  @override
  final maxHeight = 600;

  @override
  final bodyMargin = 10;

  // You need to adjust the layout to fit into your illustration.
  @override
  get layout {
    return [
      Positioned(
        child: background,
      ),
      Positioned(
        top: percentH(3),
        child: title,
      ),
      Positioned(
        top: percentH(15),
        height: percentH(actions == null ? 60 : 65),
        left: percentW(5),
        right: percentW(5),
        child: content,
      ),
      Positioned(
        bottom: percentW(5),
        left: percentW(10),
        right: percentW(10),
        child: actions ?? Container(),
      ),
    ];
  }
}

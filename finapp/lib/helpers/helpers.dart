import 'package:finapp/constants/tag-enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

String parseTag(int id) {
  return TagEnum[id];
}

IconData parseTagIcon(int id) {
  return TagEnumIcons[id];
}

Future<Null> _read() async {
  List<OcrText> texts = [];

  try {
    texts = await FlutterMobileVision.read(
      camera: FlutterMobileVision.CAMERA_BACK,
      waitTap: true,
      showText: true,
    );
    print(texts[0].value);
  } on Exception {
    texts.add(
      OcrText('Failed to recognize text'),
    );
  }
}

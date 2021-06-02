import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

Future<Null> _read() async {
  List<OcrText> texts = [];
  try {
    texts = await FlutterMobileVision.read(
      camera: FlutterMobileVision.CAMERA_BACK,
      waitTap: true,
      showText: true,
    );
  } on Exception {
    texts.add(
      OcrText('Failed to recognize text'),
    );
  }
}

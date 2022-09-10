// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static const ENV_FILE = ".env";
  static String? API_URL = dotenv.env["API_URL"];
  static String? USER_ID = dotenv.env["USER_ID"];
}

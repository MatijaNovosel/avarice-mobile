import 'package:finapp/constants/tag-enum.dart';
import 'package:flutter/material.dart';

String parseTag(int id) {
  return TagEnum[id];
}

IconData parseTagIcon(int id) {
  return TagEnumIcons[id];
}

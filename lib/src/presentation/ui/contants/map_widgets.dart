import 'package:flutter/material.dart';

abstract class MapWidgets {
  static const Map<String, Widget> mapStatusWidgets = {
    "alive": Icon(
      Icons.favorite,
      color: Colors.red,
    ),
    "dead": Icon(Icons.heart_broken_rounded),
    "unknown": Icon(Icons.help),
  };
}

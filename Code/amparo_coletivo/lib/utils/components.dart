import 'package:flutter/material.dart';

class Constants {
  static const String appName = 'Amparo Coletivo';
}

class Routes {
  static const String home = '/home';
  static const String donation = '/donation';
  static const String search = '/search';
}

class Images {
  static const String logo = 'assets/images/logo.png';
}

class Colors {
  static const Color mainColor = Color(0xFF0175C2);
}

class TextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle body = TextStyle(fontSize: 16);
}

class Dimensions {
  static const double padding = 16.0;
  static const double borderRadius = 8.0;
}

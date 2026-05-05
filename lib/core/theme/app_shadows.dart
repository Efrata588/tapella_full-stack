import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static const BoxShadow soft = BoxShadow(
    color: Color(0x33000000),
    offset: Offset(4, 4),
    blurRadius: 4,
  );

  static const BoxShadow card = BoxShadow(
    color: Color(0x80060E20),
    offset: Offset(0, 20),
    blurRadius: 40,
  );

  static const BoxShadow glow = BoxShadow(
    color: Color(0x4DADC6FF),
    offset: Offset(0, 0),
    blurRadius: 15,
  );

  static const BoxShadow subtle = BoxShadow(
    color: Color(0x33ADC6FF),
    offset: Offset(0, 0),
    blurRadius: 0,
  );

  static const BoxShadow elevation = BoxShadow(
    color: Color(0x33595959),
    offset: Offset(0, 2),
    blurRadius: 0,
  );

  static const BoxShadow focus = BoxShadow(
    color: Color(0x4D007AFF),
    offset: Offset(0, 10),
    blurRadius: 20,
  );
}

import 'package:flutter/material.dart';

abstract final class AppShadows {
  static const card = <BoxShadow>[
    BoxShadow(
      color: Color(0x140E1442),
      blurRadius: 20,
      spreadRadius: -2,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0x0A0E1442),
      blurRadius: 6,
      spreadRadius: -1,
      offset: Offset(0, 2),
    ),
  ];

  static const soft = <BoxShadow>[
    BoxShadow(
      color: Color(0x110E1442),
      blurRadius: 16,
      spreadRadius: -2,
      offset: Offset(0, 6),
    ),
  ];
}

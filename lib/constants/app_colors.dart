import 'package:awesome_board_v2/models/hold.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static const primary = Color.fromARGB(255, 134, 105, 203);

  static const background = Colors.black;
  static const secondBackground = Color.fromARGB(255, 20, 20, 20);
  static const foreground = Color.fromARGB(255, 203, 203, 203);

  static const radius = Radius.circular(7.0);
  static const radiusMedium = Radius.circular(10.0);
  static const radiusLarge = Radius.circular(15.0);
  static const radiusXLarge = Radius.circular(20.0);

  static const startHold = Colors.greenAccent;
  static const finishHold = Colors.redAccent;
  static const normalHold = Colors.blueAccent;
  static const footHold = Colors.orangeAccent;
  static const mirrorColor = Colors.yellowAccent;

  static Color colorForHoldType(HoldType holdType) {
    switch (holdType) {
      case HoldType.start:
        return startHold;
      case HoldType.finish:
        return finishHold;
      case HoldType.normal:
        return normalHold;
      case HoldType.foot:
        return footHold;
      case HoldType.unknown:
        return Colors.grey;
    }
  }

  static MaterialColor colorToMatColor(Color c) {
    Map<int, Color> map = {
      50: c.withOpacity(.1),
      100: c.withOpacity(.2),
      200: c.withOpacity(.3),
      300: c.withOpacity(.4),
      400: c.withOpacity(.5),
      500: c.withOpacity(.6),
      600: c.withOpacity(.7),
      700: c.withOpacity(.8),
      800: c.withOpacity(.9),
      900: c.withOpacity(1),
    };
    return MaterialColor(c.value, map);
  }
}

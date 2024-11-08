import 'package:flutter/material.dart';

class AppColors {
  static const int _primaryColor = 0xff1DA1F2;
  static const MaterialColor primaryColor = MaterialColor(
    _primaryColor,
    <int, Color>{
      50: Color.fromRGBO(29, 161, 242, .1),
      100: Color.fromRGBO(29, 161, 242, .2),
      200: Color.fromRGBO(29, 161, 242, .3),
      300: Color.fromRGBO(29, 161, 242, .4),
      400: Color.fromRGBO(29, 161, 242, .5),
      500: Color.fromRGBO(29, 161, 242, .6),
      600: Color.fromRGBO(29, 161, 242, .7),
      700: Color.fromRGBO(29, 161, 242, .8),
      800: Color.fromRGBO(29, 161, 242, .9),
      900: Color.fromRGBO(29, 161, 242, 1),
    },
  );
}

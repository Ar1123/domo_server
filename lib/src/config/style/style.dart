import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color get backGroundColor => Color.fromRGBO(93, 183, 217, 1);
Color get blueColorTwo => Color.fromRGBO(179, 224, 242, 1);
Color get colorText => Color.fromRGBO(17, 48, 89, 1);
Color get whiteColor => Color.fromRGBO(242, 242, 242, 1);
Color get blackColor => Colors.black;
TextStyle textStyle({
  FontWeight fontWeight = FontWeight.bold,
  required Color color,
  required double size,
}) =>
    GoogleFonts.nunito(
        textStyle: TextStyle(
      fontWeight: fontWeight,
      fontSize: size,
      color: color,
    ));

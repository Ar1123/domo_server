import 'package:domo_server/src/config/style/style.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget apbar({required String title, required Size size, Function()? action}) =>
    AppBar(
      backgroundColor: colorText,
      elevation: 2,
      title: Text(title),
      centerTitle: true,
      titleTextStyle: textStyle(
        color: whiteColor,
        size: size.height * .03,
        fontWeight: FontWeight.normal,
      ),
      leading: GestureDetector(
        onTap: action,
        child: Icon(
          Icons.arrow_back_ios,
          color: whiteColor,
        ),
      ),
    );

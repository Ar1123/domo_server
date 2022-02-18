
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../config/style/style.dart';

enum Types { error, info, succes }

void custonTopSnackbar(
    {required BuildContext context,
    required String message,
    required Types type,
    int timeb = 3}) {
  Widget? c;
  final size = MediaQuery.of(context).size;

  switch (type) {
    case Types.error:
      c = _container(
        text: message,
        icon: Icon(
          Icons.error_outline_outlined,
          color: whiteColor,
          size: size.height * .1,
        ),
        size: size,
        color: colorText,
        borderColor: whiteColor,
      );
      break;
    case Types.info:
      c = _container(
        text: message,
        icon: Icon(
          Icons.message_outlined,
          color: whiteColor,
          size: size.height * .1,
        ),
        size: size,
        color: colorText,
        borderColor: whiteColor,
      );
      break;
    case Types.succes:
      c = _container(
        text: message,
        icon: Icon(
          Icons.check,
          color: whiteColor,
          size: size.height * .1,
        ),
        size: size,
        color: whiteColor,
        borderColor: colorText,
      );
      break;
  }
  showTopSnackBar(context, c, displayDuration: Duration(seconds: timeb));
}

Widget _container({
  required String text,
  required Widget icon,
  required Size size,
  required Color color,
  required Color borderColor,
}) =>
    Material(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: size.height * .14,
        width: size.width,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: size.width * .01),
              child: icon,
            ),
            Container(
              width: size.width * .6,
              margin: EdgeInsets.only(
                left: size.width * .02,
                right: size.width * .02,
              ),
              child: Text(
                text,
                style: textStyle(
                  color: blueColorTwo,
                  fontWeight: FontWeight.bold,
                  size: size.height * .02,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: color,
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
           
            ],
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10)),
      ),
    );

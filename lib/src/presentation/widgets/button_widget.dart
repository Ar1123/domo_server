import 'package:domo_server/src/config/style/style.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.backGroundColor,
    required this.borderColor,
    required this.textColor,
    required this.text,
    required this.action,
  }) : super(key: key);
  final Color backGroundColor;
  final Color borderColor;
  final Color textColor;

  final String text;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: action,
      child: Container(
        width: size.width * .6,
        height: size.height * .07,
        alignment: Alignment.center,
        child: Text(
          text,
          style: textStyle(
            color: textColor,
            size: size.height * .02,
          ),
        ),
        decoration: BoxDecoration(
            color: backGroundColor,
            borderRadius: BorderRadius.circular(10),
           ),
      ),
    );
  }
}

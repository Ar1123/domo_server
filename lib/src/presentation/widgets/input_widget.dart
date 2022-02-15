import 'package:domo_server/src/config/style/style.dart';
import 'package:flutter/services.dart';

import 'custom_widget/custom.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputWidget extends StatelessWidget {
   InputWidget({
    Key? key,
    required this.labeltext,
    required this.onchanged,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.textInputFormatter,
    this.enabled = true,
    this.lines = 1,
  }) : super(key: key);
  final String labeltext;
  final Function(String e) onchanged;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final int lines;
  bool enabled;
  final List<TextInputFormatter>? textInputFormatter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomContainer(
        child: TextField(
      controller: textEditingController,
      onChanged: onchanged,
      enabled: enabled,
      keyboardType: textInputType,
      inputFormatters: textInputFormatter,
      maxLines: lines,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: size.width * .02),
        labelText: labeltext,
        labelStyle: textStyle(
          color: colorText,
          size: size.height * .023,
          fontWeight: FontWeight.normal,
        ),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    ));
  }
}

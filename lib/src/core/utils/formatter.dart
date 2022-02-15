import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
const knumber = r'[0-9]';

final phoneFormatter = MaskTextInputFormatter(
  mask: "### ### #### ",
  filter: {
    "#": RegExp(knumber),
  },
);
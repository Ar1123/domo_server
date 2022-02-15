import 'package:flutter/material.dart';

import '../../../config/style/style.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: blueColorTwo,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

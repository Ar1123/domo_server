import 'package:flutter/material.dart';

void customShowModalBottonSheet(
        {required BuildContext context,
        required Widget child,
        required Widget header}) =>
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      elevation: 10,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              header,
              SingleChildScrollView(
                child: Column(
                  children: [
                    child,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      context: context,
    );

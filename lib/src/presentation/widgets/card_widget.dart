import 'package:domo_server/src/config/style/style.dart';
import 'package:flutter/material.dart';

class Carwidget extends StatelessWidget {
  const Carwidget({
    Key? key,
    required this.ciudad,
    required this.fecha,
    required this.hora,
  }) : super(key: key);
  final String ciudad;
  final String fecha;
  final String hora;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .9,
      height: size.height * .15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * .03,
          ),
          _itemCard(
            text1: 'Ciudad',
            size: size,
            text2: ciudad,
          ),
          _itemCard(
            text1: 'Fecha',
            size: size,
            text2: fecha,
          ),
          _itemCard(
            text1: 'Hora',
            size: size,
            text2: hora,
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: size.width * .04),
            child: Icon(
              Icons.visibility,
              color: colorText,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: colorText,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
        color: blueColorTwo,
      ),
    );
  }

  Widget _itemCard(
          {required String text1, required Size size, required String text2}) =>
      Container(
        margin: EdgeInsets.only(
          left: size.width * .06,
        ),
        child: Row(children: [
          Container(
            width: size.width * .15,
            child: Text('$text1:',
                style: textStyle(
                  color: colorText,
                  size: size.height * .02,
                )),
          ),
          Text(
            '$text2',
            style: textStyle(
              color: colorText,
              size: size.height * .02,
              fontWeight: FontWeight.normal,
            ),
          )
        ]),
      );
}

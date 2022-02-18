import 'package:domo_server/src/config/style/style.dart';
import 'package:domo_server/src/domain/entities/service_entities.dart';
import 'package:flutter/material.dart';


class OfferedPage extends StatelessWidget {
  const OfferedPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      
    );
  }
  Widget _container(
          {required Size size, required dynamic serviceEntities, required BuildContext context}) =>
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "detailService",
              arguments: {"service": serviceEntities});
        },
        child: Container(
          height: size.height * .2,
          width: size.width,
          margin: EdgeInsets.symmetric(
              horizontal: size.width * .05, vertical: size.height * .03),
          decoration: BoxDecoration(
              color: backGroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: colorText,
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                )
              ]),
          child: Column(
            children: [
              SizedBox(
                height: size.height * .04,
              ),
              _itemCard(
                  text1: 'Ciudad:',
                  text2: '${serviceEntities.city} (${serviceEntities.dep})',
                  size: size),
              _itemCard(
                  text1: 'Fecha:',
                  text2: '${serviceEntities.date}',
                  size: size),
              _itemCard(
                  text1: 'Hora:', text2: '${serviceEntities.hour}', size: size),
            ],
          ),
        ),
      );
  Widget _itemCard(
          {required String text1, required String text2, required Size size}) =>
      Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: size.width * .15),
            width: size.width * .2,
            child: Text(
              text1,
              style: textStyle(color: colorText, size: size.height * .024),
            ),
          ),
          Text(
            text2,
            style: textStyle(
              color: colorText,
              size: size.height * .024,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      );

}
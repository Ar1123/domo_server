import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:domo_server/src/presentation/widgets/custom_widget/custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/style/style.dart';
import '../../../../core/constant/asset_images.dart';
import '../../../../data/model/service_model.dart';
import '../../../../domain/entities/service_entities.dart';
import '../../../widgets/widgets.dart';

// ignore: must_be_immutable
class DetailService extends StatelessWidget {
  DetailService({Key? key}) : super(key: key);
  ServiceEntities? serviceEntities;
  final TextEditingController _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null) {
      final encodeData = jsonEncode(arguments);
      final decodeData = jsonDecode(encodeData);
      serviceEntities =
          ServiceModel.fromJson(decodeData['service'] as Map<String, dynamic>);
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        appBar: apbar(
          title: "Detalle del servicio",
          size: size,
          action: () {
            Navigator.pop(context);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _modal(size: size, context: context);
          },
          backgroundColor: colorText,
          child: Icon(
            Icons.attach_money,
            color: whiteColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: size.height * .05,
                ),
                alignment: Alignment.center,
                child: Text(
                  serviceEntities!.category!,
                  style: textStyle(
                    color: colorText,
                    size: size.height * .05,
                  ),
                ),
              ),
              _item(
                text1: "Ciudad: ",
                text2: "${serviceEntities!.city} (${serviceEntities!.dep})",
                size: size,
              ),
              _item(
                text1: "Fecha: ",
                text2: serviceEntities!.date!,
                size: size,
              ),
              _item(
                text1: "Ciudad: ",
                text2: "${serviceEntities!.city} (${serviceEntities!.dep})",
                size: size,
              ),
              _title(size: size, text: "Descripción"),
              Container(
                height: size.height * .2,
                width: size.width * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: colorText,
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  serviceEntities!.description!,
                  style: textStyle(
                    color: colorText,
                    size: size.height * .023,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _card(img: serviceEntities!.imagesevice![0], size: size),
                  _card(img: serviceEntities!.imagesevice![1], size: size),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _item({
    required String text1,
    required String text2,
    required Size size,
  }) =>
      Container(
        margin: EdgeInsets.only(left: size.width * .1, top: size.height * .01),
        child: Row(
          children: [
            SizedBox(
              width: size.width * .2,
              child: Text(
                text1,
                style: textStyle(
                  color: colorText,
                  size: size.height * .022,
                ),
              ),
            ),
            Text(
              text2,
              style: textStyle(
                color: colorText,
                size: size.height * .022,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      );
  Widget _title({required Size size, required String text}) => Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: size.width * .1, top: size.height * .04),
        child: Text(
          text,
          style: textStyle(
            color: colorText,
            size: size.height * .025,
          ),
        ),
      );

  Widget _card({required String img, required Size size}) => Container(
        height: size.height * .25,
        width: size.width * .4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            imageUrl: img,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
                height: size.height * .02,
                width: size.width * .04,
                decoration: BoxDecoration(
                  color: blueColorTwo,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colorText,
                      offset: Offset(0, 3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: const Center(child: CircularProgressIndicator())),
            errorWidget: (context, url, error) => Image.asset(kNotImage),
          ),
        ),
        margin: EdgeInsets.only(top: size.height * .04),
        decoration: BoxDecoration(
          color: blueColorTwo,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorText,
              offset: const Offset(0, 3),
              blurRadius: 3,
            ),
          ],
        ),
      );

  void _modal({required Size size, required BuildContext context}) =>
      customShowModalBottonSheet(
          context: context,
          child: SizedBox(
            height: size.height * .3,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * .05,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * .06),
                  child: InputWidget(
                    labeltext: '\$',
                    onchanged: (e) {},
                    lines: 1,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textInputType: TextInputType.number,
                    textEditingController: _priceController,
                  ),
                ),
                SizedBox(height: size.height*.07,),
                ButtonWidget(
                  backGroundColor: colorText,
                  borderColor: colorText,
                  textColor: whiteColor,
                  text: "Enviar oferta",
                  action: () {},
                ),
              ],
            ),
          ),
          header: SizedBox(
            height: size.height * .02,
          ));
}

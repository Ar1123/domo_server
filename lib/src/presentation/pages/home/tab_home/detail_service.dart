import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:domo_server/injector.dart';
import 'package:domo_server/src/presentation/blocs/blocs.dart';
import 'package:domo_server/src/presentation/widgets/custom_widget/custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/style/style.dart';
import '../../../../core/constant/asset_images.dart';
import '../../../../data/model/service_model.dart';
import '../../../widgets/widgets.dart';

// ignore: must_be_immutable
class DetailService extends StatefulWidget {
  const DetailService({Key? key}) : super(key: key);

  @override
  State<DetailService> createState() => _DetailServiceState();
}

class _DetailServiceState extends State<DetailService> {
  ServiceModel? serviceEntities;

  final TextEditingController _priceController = TextEditingController();

  final serviceBloc = locator<ServiceBloc>();

  bool offer = false;

  bool enabled = false;

  String idOffer = "";

  String price = "";

  int progress = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null) {
      final encodeData = jsonEncode(arguments);
      final decodeData = jsonDecode(encodeData);
      serviceEntities =
          ServiceModel.fromJson(decodeData['service'] as Map<String, dynamic>);
      if (decodeData['offer'] != null) {
        offer = decodeData['offer'];
        price = decodeData['price'];
      }
      if (decodeData['idOffer'] != null) {
        idOffer = decodeData['idOffer'];
      }
      if (decodeData['progress'] != null) {
        progress = decodeData['progress'];
      }
      if (decodeData['enabled'] != null) {
        enabled = decodeData['enabled'];
      }
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
        floatingActionButton: (offer)
            ? FloatingActionButton(
                backgroundColor: colorText,
                onPressed: () {
                  _modalEdit(size: size, context: context);
                },
                child: Icon(
                  Icons.edit,
                  color: whiteColor,
                ),
              )
            : (enabled)
                ? (progress == 0)
                    ? GestureDetector(
                        onTap: () async {
                          final result = await serviceBloc.updateOffer(
                              idOffer: idOffer,
                              progrees: true,
                              data: {
                                "progress": 1,
                                "service": serviceEntities!.toJson(),
                              },
                              type: Type.editPrice);
                          if (result) {
                            progress == 1;
                            setState(() {});
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: colorText,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: colorText,
                                    offset: const Offset(0, 2),
                                    blurRadius: 2)
                              ]),
                          height: size.height * .06,
                          width: size.width * .3,
                          alignment: Alignment.center,
                          child: Text(
                            'Iniciar servicio',
                            style: textStyle(
                              color: whiteColor,
                              size: size.height * .02,
                            ),
                          ),
                        ),
                      )
                    : (progress == 1)
                        ? GestureDetector(
                            onTap: () async {
                              final result = await serviceBloc.updateOffer(
                                  idOffer: idOffer,
                                  data: {
                                    "progress": 2,
                                    "service": serviceEntities!.toJson(),
                                  },
                                  type: Type.editPrice);
                              if (result) {
                                setState(() {});
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorText,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: colorText,
                                        offset: const Offset(0, 2),
                                        blurRadius: 2)
                                  ]),
                              height: size.height * .06,
                              width: size.width * .3,
                              alignment: Alignment.center,
                              child: Text(
                                'Finalizar servicio',
                                style: textStyle(
                                  color: whiteColor,
                                  size: size.height * .02,
                                ),
                              ),
                            ),
                          )
                        : FloatingActionButton(
                            backgroundColor: colorText,
                            onPressed: () {},
                            child: Icon(
                              Icons.check,
                              color: whiteColor,
                            ),
                          )
                : FloatingActionButton(
                    onPressed: () {
                      _modal(size: size, context: context, isEdit: false);
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
              (offer)
                  ? Container(
                      width: size.width,
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: size.width * .3,
                        decoration: BoxDecoration(
                            color: colorText,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10))),
                        child: Column(
                          children: [
                            Text(
                              'Ofertaste',
                              style: textStyle(
                                  color: whiteColor, size: size.height * .023),
                            ),
                            Text(
                              price,
                              style: textStyle(
                                  color: whiteColor, size: size.height * .023),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
              Container(
                margin: EdgeInsets.only(
                  top: (offer) ? size.height * .02 : size.height * .05,
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
                mainAxisAlignment: (serviceEntities!.imagesevice!.length > 1)
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.center,
                children: [
                  _card(img: serviceEntities!.imagesevice![0], size: size),
                  (serviceEntities!.imagesevice!.length > 1)
                      ? _card(img: serviceEntities!.imagesevice![1], size: size)
                      : SizedBox(),
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

  void _modal(
          {required Size size,
          required BuildContext context,
          required bool isEdit}) =>
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
                SizedBox(
                  height: size.height * .07,
                ),
                ButtonWidget(
                  backGroundColor: colorText,
                  borderColor: colorText,
                  textColor: whiteColor,
                  text: (isEdit) ? "Editar oferta" : "Enviar oferta",
                  action: () async {
                    if (_priceController.text.isNotEmpty) {
                      if (isEdit) {
                        await serviceBloc.updateOffer(
                            idOffer: idOffer,
                            data: {
                              "service": serviceEntities!.toJson(),
                              "price": _priceController.text.trim(),
                            },
                            type: Type.editPrice);
                      } else {
                        final result = await serviceBloc.createOffer(data: {
                          "service": serviceEntities!.toJson(),
                          "price": _priceController.text.trim(),
                          "progress": 0
                        });
                        if (result) {
                          Navigator.pop(context);
                        }
                      }
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
          header: SizedBox(
            height: size.height * .02,
          ));

  void _modalEdit({required Size size, required BuildContext context}) =>
      customShowModalBottonSheet(
          context: context,
          child: SizedBox(
            height: size.height * .2,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.attach_money,
                    color: colorText,
                  ),
                  title: Text(
                    'Editar oferta',
                    style: textStyle(
                      color: colorText,
                      size: size.height * .02,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _modal(size: size, context: context, isEdit: true);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.delete_outline,
                    color: colorText,
                  ),
                  title: Text(
                    'Eliminar oferta',
                    style: textStyle(
                      color: colorText,
                      size: size.height * .02,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          header: SizedBox(
            height: size.height * .02,
          ));
}

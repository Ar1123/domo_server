import 'package:domo_server/src/config/style/style.dart';
import 'package:domo_server/src/domain/entities/offer_entities.dart';
import 'package:domo_server/src/presentation/blocs/blocs.dart';
import 'package:flutter/material.dart';

import '../../../../../../injector.dart';

class ActivePage extends StatelessWidget {
  ActivePage({Key? key}) : super(key: key);
  final serviceBloc = locator<ServiceBloc>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: FutureBuilder<List<OfferEntities>>(
        future: serviceBloc.getOffer(status: Status.active),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            List<OfferEntities> list = snapshot.data ?? [];
            if (list.isNotEmpty) {
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, index) => _container(
                    size: size, serviceEntities: list[index], context: context),
              );
            } else {
              return const Center(
                child: Text('Sin ofertas'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _container({
    required Size size,
    required OfferEntities serviceEntities,
    required BuildContext context,
  }) =>
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "detailService", arguments: {
            "service": serviceEntities.service,
            "enabled": true,
            "idOffer":serviceEntities.idOffer,
            "progress":serviceEntities.progress
          });
        },
        child: Container(
          height: size.height * .2,
          width: size.width,
          margin: EdgeInsets.symmetric(
              horizontal: size.width * .05, vertical: size.height * .03),
          decoration: BoxDecoration(
              color: blueColorTwo,
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
                  text2:
                      '${serviceEntities.service!.city} (${serviceEntities.service!.dep})',
                  size: size),
              _itemCard(
                  text1: 'Fecha:',
                  text2: '${serviceEntities.service!.date}',
                  size: size),
              _itemCard(
                  text1: 'Hora:',
                  text2: '${serviceEntities.service!.hour}',
                  size: size),
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

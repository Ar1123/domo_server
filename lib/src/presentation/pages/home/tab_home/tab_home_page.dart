import 'dart:developer';

import 'package:domo_server/injector.dart';
import 'package:domo_server/src/config/style/style.dart';
import 'package:domo_server/src/domain/entities/service_entities.dart';
import 'package:domo_server/src/domain/entities/user_entities.dart';
import 'package:domo_server/src/presentation/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabHomePage extends StatefulWidget {
  const TabHomePage({Key? key}) : super(key: key);

  @override
  State<TabHomePage> createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> {
  int _currentIndex = 0;
  bool lleno = true;
  String labor = "";
  List<String> labores = [];
  final serviceBloc = locator<ServiceBloc>();

  @override
  Widget build(BuildContext context) {
    final userBloc = locator<UserBloc>();
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocProvider(
        create: (context) => serviceBloc,
        child: Scaffold(
          backgroundColor: backGroundColor,
          body: SizedBox(
            height: size.height * 1,
            child: FutureBuilder<UserEntities>(
              future: userBloc.getUser(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  labores = [];
                  labores = snapshot.data!.labores!;
                  if (lleno) {
                    lleno = false;
                    labor = labores[0];
                    serviceBloc.getService(data: {
                      "city": snapshot.data!.city,
                      "category": labor
                    }).then((value) {});
                  }
                  return Column(
                    children: [
                      Container(
                        height: size.height * .1,
                        decoration:
                            BoxDecoration(color: backGroundColor, boxShadow: [
                          BoxShadow(
                            color: colorText,
                            offset: const Offset(0, 2),
                            blurRadius: 3,
                          )
                        ]),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: labores.length,
                            itemBuilder: (context, index) => Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.width * .02),
                                  child: GestureDetector(
                                      onTap: () {
                                        _currentIndex = index;
                                        labor = labores[index];
                                        serviceBloc.getService(data: {
                                          "city": snapshot.data!.city,
                                          "category": labor
                                        }).then((value) {});
                                        setState(() {});
                                        log(labor);
                                      },
                                      child: Chip(
                                        label: Text(
                                          labores[index],
                                          style: textStyle(
                                              color: (_currentIndex != index)
                                                  ? colorText
                                                  : whiteColor,
                                              size: size.height * .02),
                                        ),
                                        backgroundColor:
                                            (_currentIndex == index)
                                                ? colorText
                                                : whiteColor,
                                      )),
                                )),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              StreamBuilder<List<ServiceEntities>>(
                                  stream: serviceBloc.streamService,
                                  builder: (context,
                                      AsyncSnapshot<List<ServiceEntities>>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      List<ServiceEntities> list =
                                          snapshot.data ?? [];
                                      if (list.isNotEmpty) {
                                        return SizedBox(
                                          height: size.height * .8,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: list.length,
                                              itemBuilder: (_, index) =>
                                                  _container(
                                                      size: size,
                                                      serviceEntities:
                                                          list[index])),
                                        );
                                      } else {
                                        return SizedBox(
                                          height: size.height*.8,
                                          child: const Center(
                                            child: Text(
                                                'No hay servicios disponibles'),
                                          ),
                                        );
                                      }
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _container(
          {required Size size, required ServiceEntities serviceEntities}) =>
      Container(
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
                text1: 'Fecha:', text2: '${serviceEntities.date}', size: size),
            _itemCard(
                text1: 'Hora:', text2: '${serviceEntities.hour}', size: size),
          ],
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
          Container(
            child: Text(
              text2,
              style: textStyle(
                color: colorText,
                size: size.height * .024,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      );
}

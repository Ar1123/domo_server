import 'dart:developer';

import 'package:domo_server/injector.dart';
import 'package:domo_server/src/config/style/style.dart';
import 'package:domo_server/src/domain/entities/user_entities.dart';
import 'package:domo_server/src/presentation/blocs/blocs.dart';
import 'package:flutter/material.dart';

class TabHomePage extends StatefulWidget {
  const TabHomePage({Key? key}) : super(key: key);

  @override
  State<TabHomePage> createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> {
  int _currentIndex = 0;
  String labor = "";
                List<String> labores = [];


  @override
  Widget build(BuildContext context) {
    final userBloc = locator<UserBloc>();
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: SizedBox(
          height: size.height * 1,
          child: FutureBuilder<UserEntities>(
            future: userBloc.getUser(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                labores =[];
                labores = snapshot.data!.labores!;
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
                                      backgroundColor: (_currentIndex == index)
                                          ? colorText
                                          : whiteColor,
                                    )),
                              )),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                              Center(
                                child: Text(labor),
                              )
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
    );
  }
}

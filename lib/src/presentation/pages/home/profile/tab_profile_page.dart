import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:domo_server/injector.dart';
import 'package:domo_server/src/config/style/style.dart';
import 'package:domo_server/src/core/constant/asset_images.dart';
import 'package:domo_server/src/core/constant/words.dart';
import 'package:domo_server/src/presentation/blocs/blocs.dart';
import 'package:domo_server/src/presentation/widgets/custom_widget/custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'personal_data_page.dart';
import 'professional_data_page.dart';

class TabProfilePage extends StatelessWidget {
  TabProfilePage({Key? key}) : super(key: key);

  final userBloc = locator<UserBloc>();
  String img = "";
  bool isFile = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocProvider(
        create: (context) => userBloc,
        child: Scaffold(
          backgroundColor: backGroundColor,
          body: Stack(
            children: [
              Column(
                children: [
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return BlocListener<UserBloc, UserState>(
                        listener: (context, state) {
                          if (state is ShowImageFromLocal) {
                            img = state.img;
                            isFile = true;
                            loading = true;
                              userBloc.addImage(img: img).then((value){
                                loading = false;
                              });
                          }
                        },
                        child: GestureDetector(
                          onTap: () {
                            _typeImg(context, size);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: size.height * .04,
                            ),
                            child: SizedBox(
                              height: size.height * .15,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.red,
                                  child: (img.isNotEmpty && isFile)
                                      ? FadeInImage(
                                          placeholder: const AssetImage(kLoading),
                                          image: FileImage(File(img)))
                                      : CachedNetworkImage(
                                          imageUrl: img ,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            kImageUser,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                  width: size.width * .3,
                                  height: size.height * .15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: size.height * .72,
                    child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        backgroundColor: backGroundColor,
                        appBar: PreferredSize(
                          preferredSize: Size(double.infinity, size.height * .2),
                          child: TabBar(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            labelStyle: textStyle(
                              color: colorText,
                              size: size.height * .02,
                            ),
                            indicatorColor: colorText,
                            labelColor: colorText,
                            tabs: const [
                              Text(ktabOne),
                              Text(ktabTwo),
                            ],
                          ),
                        ),
                        body: TabBarView(
                          children: [
                            PersonalDataPage(),
                            ProfessionalDataPage(
                              userBloc: userBloc,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              (loading)?Container(
                height: size.height,
                color: Colors.black.withOpacity(.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ):const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  void _typeImg(BuildContext context, Size size) => customShowModalBottonSheet(
      context: context,
      child: SizedBox(
        height: size.height * .18,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                context
                    .read<UserBloc>()
                    .add(const OnGetImageFromLocalUser(type: 1));
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.camera_alt_outlined,
                color: colorText,
              ),
              title: Text('Usar camara'),
            ),
            ListTile(
              onTap: () {
                context
                    .read<UserBloc>()
                    .add(const OnGetImageFromLocalUser(type: 2));
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.add_a_photo,
                color: colorText,
              ),
              title: Text('Usar galeria'),
            ),
          ],
        ),
      ),
      header: SizedBox(
        height: size.height * .03,
      ));
}

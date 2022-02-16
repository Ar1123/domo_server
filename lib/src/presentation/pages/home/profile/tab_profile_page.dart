import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injector.dart';
import '../../../../config/style/style.dart';
import '../../../../core/constant/asset_images.dart';
import '../../../../core/constant/words.dart';
import '../../../../domain/entities/user_entities.dart';
import '../../../blocs/blocs.dart';
import '../../../widgets/custom_widget/custom.dart';
import '../../../widgets/widgets.dart';
import 'personal_data_page.dart';
import 'professional_data_page.dart';

// ignore: must_be_immutable
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
          appBar: apbar(title: "Perfil",action: (){
            Navigator.pop(context);
          }, size: size),
          backgroundColor: backGroundColor,
          body: FutureBuilder<UserEntities>(
            future: userBloc.getUser(),
            builder: (context, snapshot) {
                if(snapshot.hasData){
                  img =snapshot.data!.img!;
                    return Stack(
                children: [
                  SingleChildScrollView
                  (
                    child: Column(
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
                                      child: SizedBox(
                                        child: (img.isNotEmpty && isFile)
                                            ? FadeInImage(
                                                placeholder: const AssetImage(kLoading),
                                                image: FileImage(File(img), ),fit: BoxFit.cover,)
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
                          height: size.height * .6,
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
                                  PersonalDataPage(
                                    userBloc: userBloc,
                                    userEntities: snapshot.data!,
                                  ),
                                  ProfessionalDataPage(
                                    userBloc: userBloc,
                                    userEntities: snapshot.data!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (loading)?Container(
                    height: size.height,
                    color: Colors.black.withOpacity(.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ):const SizedBox()
                ],
              );
                }else{
                    return const Center(child: CircularProgressIndicator(),);
                } 
            }
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

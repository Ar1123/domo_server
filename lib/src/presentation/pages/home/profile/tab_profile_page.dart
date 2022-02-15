import 'package:cached_network_image/cached_network_image.dart';
import 'package:domo_server/injector.dart';
import 'package:domo_server/src/config/style/style.dart';
import 'package:domo_server/src/core/constant/asset_images.dart';
import 'package:domo_server/src/core/constant/words.dart';
import 'package:domo_server/src/presentation/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'personal_data_page.dart';
import 'professional_data_page.dart';

class TabProfilePage extends StatelessWidget {
   TabProfilePage({Key? key}) : super(key: key);

  final userBloc = locator<UserBloc>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocProvider(
        create: (context) => userBloc,
        child: Scaffold(
          backgroundColor: backGroundColor,
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: size.height * .04,
                ),
                child: SizedBox(
                  height: size.height * .15,
                  child: ClipOval(
                    child: Container(
                      color: Colors.red,
                      child: CachedNetworkImage(
                        imageUrl: "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset(
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
                        ProfessionalDataPage(userBloc: userBloc,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

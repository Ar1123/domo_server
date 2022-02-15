import 'package:cached_network_image/cached_network_image.dart';
import 'package:domo_server/src/config/style/style.dart';
import 'package:domo_server/src/core/constant/asset_images.dart';
import 'package:domo_server/src/presentation/pages/pages.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
    final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    _initController();
    super.initState();
  }

  int _currentIndex = 0;
  void _initController() {
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
    _tabController!.addListener(() {});
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: _drawer(size),
        ),
        backgroundColor: backGroundColor,
        body: TabBarView(
          
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            TabHomePage(),
            TabSearchPage(),
            TabOfferPage(),
            Text(''),
          ],
        ),
        bottomNavigationBar: Container(
          color: backGroundColor,
          padding: const EdgeInsets.only(
            bottom: 20,
            right: 20,
            left: 20,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(50.0),
            ),
            child: Container(
              color: Colors.white,
              child: TabBar(
                onTap: (index){
                  if(index<3){
                    _currentIndex = index;
                  }
                  if(index==3){
                    _scaffoldKey.currentState!.openDrawer();
                  }
                  _tabController!.animateTo(_currentIndex);
                },
                controller: _tabController,
                labelColor: const Color(0xFFC41A3B),
                unselectedLabelColor: Colors.red,
                labelStyle: const TextStyle(fontSize: 10.0),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.black54, width: 0.0),
                ),
                indicatorColor: Colors.black54,
                tabs: [
                     Tab(
                    icon: Icon(
                      Icons.home_outlined,
                      size: 24.0,
                      color: colorText,
                    ),
                  ),
                     Tab(
                    icon: Icon(
                      Icons.search,
                      size: 24.0,
                      color: colorText,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.attach_money,
                      size: 24.0,
                      color: colorText,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.menu,
                      size: 24.0,
                      color: colorText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
   Widget _drawer(Size size) => Container(
    color: backGroundColor,
    child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: size.width * .03,
                        bottom: size.height * .01,
                        top: size.height * .03),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorText,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: "https://www.online-image-editor.com/styles/2019/images/power_girl_editor.png",
                        placeholder: (_, __) => Center(
                          child: Container(
                            height: size.height * .02,
                            width: size.width * .04,
                            color: whiteColor,
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (_, __, ___) => Image.asset(
                          kImageUser,
                          fit: BoxFit.cover,
                        ),
                        width: 90.0,
                        height: 90.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  top: size.height * .01,
                  left: size.height * .03,
                  right: size.height * .03,
                ),
                child: Text(
                  "Usuario servidor :)",
                  style: textStyle(
                    color: colorText,
                    size: size.height * .035,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _itemTap(
                text: "Perfil",
                icon: Icon(
                  Icons.person_outline,
                  color: colorText,
                ),
                action: () {
                  Navigator.pushNamed(context, 'profilePage');
                },
                size: size,
                isIcon: false,
              ),
              _itemTap(
                text: "Aspectos legales",
                icon: Icon(
                  Icons.description_outlined,
                  color: colorText,
                ),
                action: () {},
                size: size,
                isIcon: false,
              ),
              _itemTap(
                text: "Comentario",
                icon: Icon(
                  Icons.message_outlined,
                  color: colorText,
                ),
                action: () {},
                size: size,
                isIcon: false,
              ),
              _itemTap(
                text: "Salir",
                icon: Icon(
                  Icons.power_settings_new_rounded,
                  color: colorText,
                ),
                action: () async {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'authPhone', (Route<dynamic> route) => false);
                },
                size: size,
                isIcon: true,
              ),
            ],
          ),
        ),
  );
  Widget _itemTap(
          {required String text,
          required Widget icon,
          required Function() action,
          required Size size,
          required bool isIcon}) =>
      ListTile(
        title: Text(
          text,
          style: textStyle(
            size: size.height * .02,
            color: colorText,
            fontWeight: FontWeight.normal,
          ),
        ),
        trailing: (isIcon)
            ? const SizedBox()
            : Icon(
                Icons.keyboard_arrow_right,
                color: colorText,
              ),
        onTap: action,
        leading: icon,
      );

}

import 'package:domo_server/src/config/style/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabOfferPage extends StatefulWidget {
  const TabOfferPage({Key? key}) : super(key: key);

  @override
  State<TabOfferPage> createState() => _TabOfferPageState();
}

class _TabOfferPageState extends State<TabOfferPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: backGroundColor,
          appBar: PreferredSize(
            preferredSize: Size(
              size.width * 1,
              size.height * .12,
            ),
            child: AppBar(
              backgroundColor: backGroundColor,
              bottom: TabBar(
                isScrollable: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                labelColor: colorText,
                labelPadding: EdgeInsets.all(size.width * .012),
                labelStyle: textStyle(
                  color: colorText,
                  size: size.height * .018,
                ),
                indicatorColor: colorText,
                unselectedLabelColor: blackColor,
                controller: _tabController,
                tabs: [
                  _item(
                    'Activas',
                    size,
                    const FaIcon(
                      FontAwesomeIcons.clock,
                    ),
                  ),
                  _item(
                    'Ofertadas',
                    size,
                    const Icon(
                      Icons.monetization_on_outlined,
                    ),
                  ),
                  _item(
                    'Historial',
                    size,
                    const Icon(
                      Icons.history,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Text('1'),
              Text('2'),
              Text('3'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(
    String text,
    Size size,
    Widget icon,
  ) =>
      Column(
        children: [
          Container(
            width: size.width * .26,
            height: size.height * .07,
            child: icon,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: blueColorTwo,
              border: Border.all(
                color: colorText,
              ),
              shape: BoxShape.circle,
            ),
          ),
          Text(text)
        ],
      );
}

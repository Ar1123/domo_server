

import 'package:domo_server/src/config/style/style.dart';
import 'package:flutter/material.dart';

class TabSearchPage extends StatelessWidget {
  const TabSearchPage({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: Column(
          children: [
            _inputSearch(size: size),
          ],
        ),
      ),
    );
  }

  Widget _inputSearch({required Size size}) => Container(
        height: size.height * .07,
        child: ListTile(
          leading: Icon(
            Icons.search_outlined,
            color: colorText,
          ),
          title: const TextField(
            
            decoration: InputDecoration(
              hintText: 'Buscar',
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
          trailing: Icon(
            Icons.clear_outlined,
            color: colorText,
          ),
        ),
        decoration: BoxDecoration(color: backGroundColor, boxShadow: [
          BoxShadow(
            color: colorText,
            offset: Offset(0, 2),
            blurRadius: 3,
          )
        ]),
      );
}
import 'package:domo_server/src/config/style/style.dart';
import 'package:domo_server/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PersonalDataPage extends StatelessWidget {
  PersonalDataPage({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * .1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .05,
            ),
            InputWidget(
              labeltext: 'Nombre',
              onchanged: (e) {},
              textEditingController: _nameController,
            ),
            SizedBox(
              height: size.height * .02,
            ),
            InputWidget(
              labeltext: 'Apellido',
              onchanged: (e) {},
              textEditingController: _lastNameController,
            ),
            SizedBox(
              height: size.height * .02,
            ),
            InputWidget(
              labeltext: 'Biógrafía',
              onchanged: (e) {},
              textEditingController: _biographyController,
              lines: 4,
            ),
            SizedBox(
              height: size.height * .02,
            ),
            InputWidget(
              labeltext: 'Teléfono',
              enabled: false,
              onchanged: (e) {},
              textEditingController: _phoneController,
              lines: 1,
            ),
            SizedBox(
              height: size.height * .05,
            ),
            ButtonWidget(
              backGroundColor: colorText,
              borderColor: colorText,
              textColor: whiteColor,
              text: 'Guardar',
              action: () {},
            ),
            SizedBox(
              height: size.height * .05,
            ),
          ],
        ),
      ),
    );
  }
}

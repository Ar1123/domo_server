import 'package:domo_server/src/config/style/style.dart';
import 'package:domo_server/src/presentation/widgets/custom_widget/custom.dart';
import 'package:domo_server/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfessionalDataPage extends StatelessWidget {
  ProfessionalDataPage({Key? key}) : super(key: key);
  final TextEditingController _experienceYear = TextEditingController();
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
              labeltext: 'Años de experiencia',
              textInputType: TextInputType.number,
              textInputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onchanged: (e) {},
              textEditingController: _experienceYear,
            ),
            SizedBox(
              height: size.height * .02,
            ),
            _text(text1: 'Ciudad de residencia', size: size),
            CustomContainer(
              child: ListTile(
                onTap: () {},
                title: Text(
                  'Seleccionar',
                  style: textStyle(
                    color: colorText,
                    size: size.height * .023,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                trailing: Icon(
                  Icons.add_circle_outline_outlined,
                  color: colorText,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            _text(text1: 'Agrega las labores que dominas', size: size),
            CustomContainer(
              child: ListTile(
                onTap: () {
                  _showModal(
                    size: size,
                    context: context,
                  );
                },
                title: Text(
                  'Seleccionar',
                  style: textStyle(
                    color: colorText,
                    size: size.height * .023,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                trailing: Icon(
                  Icons.add_circle_outline_outlined,
                  color: colorText,
                ),
              ),
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

  Widget _text({required String text1, required Size size}) => Container(
        margin: EdgeInsets.only(bottom: size.height * .01),
        alignment: Alignment.centerLeft,
        child: Text(
          text1,
          style: textStyle(
            color: colorText,
            size: size.height * .023,
            fontWeight: FontWeight.normal,
          ),
        ),
      );

  void _showModal({required Size size, required BuildContext context}) =>
      customShowModalBottonSheet(
          context: context,
          child: SizedBox(
            height: size.height * .5,
          ),
          header: SizedBox(
            height: size.height * .03,
          ));
}

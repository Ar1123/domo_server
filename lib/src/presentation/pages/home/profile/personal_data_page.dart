import 'package:domo_server/src/config/style/style.dart';
import 'package:domo_server/src/domain/entities/user_entities.dart';
import 'package:domo_server/src/presentation/blocs/blocs.dart';
import 'package:domo_server/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({Key? key, required this.userBloc, required this.userEntities}) : super(key: key);
  final UserBloc userBloc;
  final UserEntities userEntities;

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _biographyController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  @override
  void initState() {
      _initData();
    super.initState();
  }
  void _initData(){
    _nameController.value = _nameController.value.copyWith(text: widget.userEntities.name);
    _lastNameController.value = _nameController.value.copyWith(text: widget.userEntities.lastName);
    _biographyController.value = _nameController.value.copyWith(text: widget.userEntities.biography);
    _phoneController.value = _nameController.value.copyWith(text: widget.userEntities.phone);
 
  }

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
              action: () async {
                await widget.userBloc.updateUser(data: {
                  "name": _nameController.text.trim(),
                  "lastName": _lastNameController.text.trim(),
                  "biography": _biographyController.text.trim(),
                });
              },
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

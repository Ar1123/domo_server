import 'package:domo_server/src/config/style/style.dart';
import 'package:domo_server/src/domain/entities/category_service_entities.dart';
import 'package:domo_server/src/presentation/blocs/blocs.dart';
import 'package:domo_server/src/presentation/widgets/custom_widget/custom.dart';
import 'package:domo_server/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfessionalDataPage extends StatefulWidget {
  const ProfessionalDataPage({Key? key, required this.userBloc})
      : super(key: key);
  final UserBloc userBloc;

  @override
  State<ProfessionalDataPage> createState() => _ProfessionalDataPageState();
}

class _ProfessionalDataPageState extends State<ProfessionalDataPage> {
  final TextEditingController _experienceYear = TextEditingController();

  List<String> _categories = [];
  void _addItem(String item) {
    if (!_categories.contains(item)) {
      _categories.add(item);
    }
  }

  void _deleteItem(String item) {
    _categories.remove(item);
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
              height: (_categories.isEmpty) ? 0 : size.height * .1,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (_, index) => Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * .03),
                        child: Chip(
                          label: Text(_categories[index]),
                          onDeleted: () {
                            _deleteItem(_categories[index]);
                            setState(() {});
                          },
                        ),
                      )),
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
          child: StatefulBuilder(
            builder: (_, states) => SizedBox(
              height: size.height * .5,
              child: FutureBuilder<List<CategoryServiceEntities>>(
                future: widget.userBloc.getCategoryService(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    List<CategoryServiceEntities> list = snapshot.data ?? [];
                    if (list.isNotEmpty) {
                      return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (_, index) => ListTile(
                                onTap: () {
                                  if (_categories
                                      .contains(list[index].service)) {
                                    _deleteItem(list[index].service!);
                                  } else {
                                    _addItem(list[index].service!);
                                  }
                                  setState(() {});
                                  states(() {});
                                },
                                leading:
                                    (_categories.contains(list[index].service!))
                                        ? Icon(
                                            Icons.radio_button_checked_outlined,
                                            color: colorText,
                                          )
                                        : Icon(
                                            Icons.radio_button_off_outlined,
                                            color: colorText,
                                          ),
                                title: Text(
                                  list[index].service!,
                                ),
                              ));
                    } else {
                      return const Center(
                        child: Text('No hay categorias disponibles :('),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          header: SizedBox(
            // height: size.height * .03,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancelar',
                    style: textStyle(
                      color: colorText,
                      size: size.height * .03,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                    style: textStyle(
                      color: colorText,
                      size: size.height * .03,
                    ),
                  ),
                ),
              ],
            ),
          ));
}

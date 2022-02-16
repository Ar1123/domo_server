import 'package:domo_server/src/domain/entities/city_entities.dart';
import 'package:domo_server/src/presentation/blocs/blocs.dart';
import 'package:flutter/material.dart';

import '../../../injector.dart';

class DelegeateCity extends SearchDelegate<CityEntities> {
  List<CityEntities> list;
  final userBloc = locator<UserBloc>();

  DelegeateCity({
    required this.list,
  }) : super(searchFieldLabel: 'Buscar');
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () {
          close(
              context,
              const CityEntities(
                city: "",
                departamento: "",
                id: 0,
              ));
        },
        icon: const Icon(Icons.keyboard_arrow_left));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) {
      return const Text('no hay valor');
    }
    return FutureBuilder<List<CityEntities>>(
        future: userBloc.getCity(city: query),
        builder: (_, AsyncSnapshot<List<CityEntities>> sbapshot) {
          if (sbapshot.hasData) {
            List<CityEntities> listf = sbapshot.data ?? [];
            return _showCitys(context, listf);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    return FutureBuilder<List<CityEntities>>(
        future: userBloc.getCity(city: query),
        builder: (_, AsyncSnapshot<List<CityEntities>> sbapshot) {
          if (sbapshot.hasData) {
            List<CityEntities> listf = sbapshot.data ?? [];
            return _showCitys(context, listf);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _showCitys(BuildContext context, List<CityEntities> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, index) => ListTile(
              onTap: () {
                close(context, list[index]);
              },
              title: Text(list[index].city.toString()),
              subtitle: Text(list[index].departamento.toString()),
            ));
  }
}

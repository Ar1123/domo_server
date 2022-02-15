import 'package:equatable/equatable.dart';

class CityEntities extends Equatable {
  final int? id;
  final String? departamento;
  final String? city;
  final List<String>? ciudades;

  const CityEntities({
    this.id,
    this.departamento,
    this.ciudades,
    this.city,
  });

  @override
  List<Object?> get props => [];
}



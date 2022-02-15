import 'package:equatable/equatable.dart';

class ServiceEntities extends Equatable {
  final String? date;
  final List<String>? imagesevice;
  final String? uid;
  final String? hour;
  final String? city;
  final String? description;
  final String? id;
  final String? dep;
  final String? category;
  final bool? status;
  final bool? finalizada;

  ServiceEntities({
    this.date,
    this.imagesevice,
    this.uid,
    this.hour,
    this.city,
    this.description,
    this.id,
    this.dep,
    this.status,
    this.finalizada,
    this.category,
  });

  @override
  List<Object?> get props => [
        date,
        imagesevice,
        uid,
        hour,
        city,
        description,
        id,
        dep,
        status,
        finalizada,
        category,
      ];
}

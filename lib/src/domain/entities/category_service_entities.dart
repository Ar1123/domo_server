import 'package:equatable/equatable.dart';

class CategoryServiceEntities extends Equatable {
  final String? service;
  final String? id;

  const CategoryServiceEntities({
    this.service,
    this.id,
  });
  @override
  List<Object?> get props => [
        service,
        id,
      ];
}

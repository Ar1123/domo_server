import 'package:equatable/equatable.dart';

class UserEntities implements Equatable {
  final bool? accountComplete;
  final bool? active;
  final String? uid;
  final String? lastName;
  final String? name;
  final String? phone;
  final String? typeIde;
  final String? ide;
  final String? img;
  final String? biography;
  final List<String>? labores;
  final String? city;
  final String? dep;
  final String? experienceYear;

  UserEntities({
    this.accountComplete,
    this.active,
    this.uid,
    this.ide,
    this.lastName,
    this.name,
    this.phone,
    this.typeIde,
    this.img,
    this.biography,
    this.labores,
    this.city,
    this.dep,
    this.experienceYear,
  });

  @override
  List<Object?> get props => [
        accountComplete,
        active,
        uid,
        ide,
        lastName,
        name,
        phone,
        typeIde,
        img,
        biography,
        labores,
        city,
        dep,
        experienceYear,
      ];

  @override
  bool? get stringify => true;
}

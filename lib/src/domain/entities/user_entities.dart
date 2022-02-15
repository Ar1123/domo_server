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

  UserEntities({
    this.accountComplete,
    this.active,
    this.uid,
    this.ide,
    this.lastName,
    this.name,
    this.phone,
    this.typeIde,
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
      ];

  @override
  bool? get stringify => true;
}

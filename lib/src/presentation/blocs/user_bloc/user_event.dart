part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

}

class OnGetImageFromLocalUser extends UserEvent{
final int type;

  const OnGetImageFromLocalUser({required this.type});

  @override
  List<Object?> get props => [];


}
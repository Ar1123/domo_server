part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class ShowImageFromLocal extends UserState {
  final String img;

  const ShowImageFromLocal({required this.img});
}

class NextState extends UserInitial {}

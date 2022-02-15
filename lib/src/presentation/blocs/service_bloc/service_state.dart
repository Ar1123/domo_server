part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();
  
  @override
  List<Object> get props => [];
}

class ServiceInitial extends ServiceState {}

class ShowImageFromLocal extends ServiceState {
  final List<String> path;

  const ShowImageFromLocal({
    required this.path,
  });
}
class NextStateC extends ServiceState{}
class ErrorStateC extends ServiceState{}

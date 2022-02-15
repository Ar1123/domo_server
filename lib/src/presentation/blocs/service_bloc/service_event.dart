part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();
}

class OnEventGetImageFromLocal extends ServiceEvent {
  final int type;
  OnEventGetImageFromLocal({
    required this.type,
  });

  @override
  List<Object?> get props => [
        type,
      ];
}

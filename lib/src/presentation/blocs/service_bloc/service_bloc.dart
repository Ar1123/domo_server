import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:domo_server/src/domain/entities/service_entities.dart';
import 'package:domo_server/src/domain/usecase/service_use_case.dart';
import 'package:equatable/equatable.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceUseCase serviceUseCase;
  ServiceBloc({required this.serviceUseCase}) : super(ServiceInitial()) {
    on<ServiceEvent>((event, emit) {});
  }

  final StreamController<List<ServiceEntities>> _streamService =
      StreamController<List<ServiceEntities>>.broadcast();

  Stream<List<ServiceEntities>> get streamService => _streamService.stream;

  Future<void> getService({required Map<String, dynamic> data}) async {
    final result = await serviceUseCase.getServiceById(data: data);

    result.fold((l) => {}, (r) {
      _streamService.add(r);
    });
  }

  @override
  Future<void> close() {
    _streamService.close();
    return super.close();
  }
}

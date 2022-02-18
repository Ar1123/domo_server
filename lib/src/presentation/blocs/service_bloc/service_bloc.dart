import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domo_server/src/presentation/blocs/blocs.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/service_entities.dart';
import '../../../domain/usecase/service_use_case.dart';
import '../../../domain/usecase/use_case_domain.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceUseCase serviceUseCase;
  final OfferUseCase offerUseCase;
  final UserBloc userBloc;
  ServiceBloc({
    required this.serviceUseCase,
    required this.userBloc,
    required this.offerUseCase,
  }) : super(ServiceInitial()) {
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

  Future<bool> createOffer({required Map<String, dynamic> data}) async {
    bool status = false;
    final String idOffer = DateTime.now().millisecondsSinceEpoch.toString() +
        "" +
        DateTime.now().year.toString() +
        "" +
        DateTime.now().day.toString();
    final service = {
      "service": data['service'],
      "owner": await userBloc.getIdUSer(),
      "client": data['service']["uid"],
      "price": data['price'],
      "status": true,
      "acept": false,
    };
    final result = await offerUseCase.createOffer(data: service, id: idOffer);
    result.fold((l) {}, (r) {
      status = r;
    });
    return status;
  }
}

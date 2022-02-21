import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:domo_server/src/domain/entities/offer_entities.dart';
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
  final NotificationUseCase notificationUseCase;
  ServiceBloc({
    required this.serviceUseCase,
    required this.userBloc,
    required this.offerUseCase,
    required this.notificationUseCase,
  }) : super(ServiceInitial()) {
    on<ServiceEvent>((event, emit) {});
  }

  final StreamController<List<ServiceEntities>> _streamService =
      StreamController<List<ServiceEntities>>.broadcast();

  final StreamController<List<OfferEntities>> _streamOffer =
      StreamController<List<OfferEntities>>.broadcast();

  Stream<List<ServiceEntities>> get streamService => _streamService.stream;

  Future<void> getService({required Map<String, dynamic> data}) async {
    List<ServiceEntities> listTemv = [];
    List<ServiceEntities> listTemp = [];
    final result = await serviceUseCase.getServiceById(data: data);
    final id = await userBloc.getIdUSer();

    result.fold((l) => {}, (r) {
      listTemv = r;
    });

    for (var i = 0; i < listTemv.length; i++) {
      final getOffer = await offerUseCase.getOfferById(
        idUser: id,
        idService: listTemv[i].id!,
      );
      getOffer.fold((l) {}, (r) {
        if (r.owner == null) {
          listTemp.add(listTemv[i]);
        }
      });
    }

    _streamService.add(listTemp);
  }

  @override
  Future<void> close() {
    _streamService.close();
    return super.close();
  }

/*
.......##.......##..#######..########.########.########.########.
......##.......##..##.....##.##.......##.......##.......##.....##
.....##.......##...##.....##.##.......##.......##.......##.....##
....##.......##....##.....##.######...######...######...########.
...##.......##.....##.....##.##.......##.......##.......##...##..
..##.......##......##.....##.##.......##.......##.......##....##.
.##.......##........#######..##.......##.......########.##.....##
*/
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
      "idService": data['service']["id"],
      "price": data['price'],
      "status": true,
      "acept": false,
      "progress": data['progress'],
      "idOffer": idOffer,
    };
    final result = await offerUseCase.createOffer(data: service, id: idOffer);
    result.fold((l) {}, (r) async {
      status = r;

      final getTogetoken = await userBloc.getToken(id: data['service']['uid']);

      notificationUseCase
          .sendNotification(
        message: "Oh!, alguien ha ofertado a tu servico, ven y miremos",
        token: getTogetoken,
        title: "Nueva oferta",
      )
          .then((value) {
        log("$value");
      });
    });
    return status;
  }

  Future<List<OfferEntities>> getOffer({required Status status}) async {
    List<OfferEntities> list = [];
    final result =
        await offerUseCase.getAllOfferById(id: await userBloc.getIdUSer());

    result.fold((l) {}, (r) {
      if (status == Status.offered) {
        for (var element in r) {
          if (!element.acept! && element.status!) {
            list.add(element);
          }
        }
      }
      if (status == Status.active) {
        for (var element in r) {
          if (element.acept! && !element.status!) {
            list.add(element);
          }
        }
      }
    });
    return list;
  }

  Future<bool> updateOffer(
      {required String idOffer,
      required Map<String, dynamic> data,
      required Type type,
      bool progrees = false}) async {
    bool status = false;

    final result = await offerUseCase.updateOffer(
        idOffer: idOffer,
        data: (progrees)
            ? {"progress": data['progress']}
            : {"price": data['price']});
    result.fold((l) {}, (r) async {
      status = r;
      final getTogetoken = await userBloc.getToken(id: data['service']['uid']);

      if (type == Type.editPrice) {
        notificationUseCase
            .sendNotification(
          message:
             (progrees)?'una de tus ofertas, ya esta en progreso.': "hey!, una de tus ofertas a ha sido modificada, ven y dale un vistazo",
          token: getTogetoken,
          title: "Oferta modificada",
        )
            .then((value) {
          log("$value");
        });
      }
    });
    return status;
  }
}

enum Status {
  active,
  offered,
  history,
}
enum Type {
  delete,
  editPrice,
}

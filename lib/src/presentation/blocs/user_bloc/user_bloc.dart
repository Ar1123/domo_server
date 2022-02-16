import 'package:bloc/bloc.dart';
import 'package:domo_server/src/domain/entities/city_entities.dart';
import 'package:domo_server/src/domain/entities/user_entities.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/category_service_entities.dart';
import '../../../domain/usecase/use_case_domain.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CategoryServiceUseCase categoryServiceUseCase;
  final AuthUseCaseDomnain authUseCaseDomnain;
  final UserUSerCaseDomain uSerCaseDomain;
  final LocalCityUseCase localCityUseCase;

  final GetImageFromLocalUseCase getImageFromLocalUseCase;
  UserBloc({
    required this.categoryServiceUseCase,
    required this.authUseCaseDomnain,
    required this.uSerCaseDomain,
    required this.getImageFromLocalUseCase,
    required this.localCityUseCase,
  }) : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
    on<OnGetImageFromLocalUser>(_onGetimageFromLocal);
  }

  Future<List<CategoryServiceEntities>> getCategoryService() async {
    List<CategoryServiceEntities> list = [];

    final result = await categoryServiceUseCase.getCategoryservice();
    result.fold((l) {}, (r) {
      list = r;
    });
    return list;
  }

  Future<String> getIdUSer() async {
    String id = "";
    final result = await authUseCaseDomnain.getUserId();
    result.fold((l) {}, (r) {
      id = r;
    });

    return id;
  }

  Future<bool> addImage({required String img}) async {
    bool status = false;
    final result =
        await uSerCaseDomain.addImage(file: img, id: await getIdUSer());
    result.fold((l) {}, (r) {
      status = r;
    });

    return status;
  }

  Future<UserEntities> getUser() async {
    UserEntities userEntities = UserEntities();
    final result = await uSerCaseDomain.getUser(id: await getIdUSer());
    result.fold((l) {}, (r) {
      userEntities = r;
    });
    return userEntities;
  }

  Future<bool> updateUser({required Map<String, dynamic> data}) async {
    bool status = false;
    final result =
        await uSerCaseDomain.updateUser(data: data, id: await getIdUSer());

    result.fold((l) {}, (r) {
      status = r;
    });
    return status;
  }

  Future<bool> updateImage({required Map<String, dynamic> data}) async {
    bool status = false;

    final result = await uSerCaseDomain.updateUser(
      data: data,
      id: await getIdUSer(),
    );
    result.fold((l) {}, (r) {
      status = r;
    });
    return status;
  }

  void _onGetimageFromLocal(
      OnGetImageFromLocalUser event, Emitter<UserState> emmiter) async {
    String img = "";

    if (event.type == 1) {
      final result = await getImageFromLocalUseCase.getimageFromLocal(type: 1);
      img = result;
    } else {
      final result = await getImageFromLocalUseCase.getimageFromLocal(type: 2);
      img = result;
    }

    emmiter(ShowImageFromLocal(img: img));
    emmiter(NextState());
  }

  
  Future<List<CityEntities>> getCity({required String city}) async {
    List<CityEntities> list = [];
    final result = await localCityUseCase.getById(data: {
      "city": city,
    });
    result.fold((l) {}, (r) {
      list = r;
    });
    return list;
  }
}

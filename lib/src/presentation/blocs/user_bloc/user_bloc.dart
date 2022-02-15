import 'package:bloc/bloc.dart';
import 'package:domo_server/src/domain/entities/category_service_entities.dart';
import 'package:domo_server/src/domain/usecase/use_case_domain.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CategoryServiceUseCase categoryServiceUseCase;
  UserBloc({
    required this.categoryServiceUseCase,
  }) : super(UserInitial()) {
    on<UserEvent>((event, emit) {});
  }

  Future<List<CategoryServiceEntities>> getCategoryService() async {
    List<CategoryServiceEntities> list = [];

    final result = await categoryServiceUseCase.getCategoryservice();
    result.fold((l) {}, (r) {
      list = r;
    });
    return list;
  }
}

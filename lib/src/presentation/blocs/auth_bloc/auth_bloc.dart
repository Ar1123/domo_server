// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:domo_server/src/core/constant/words.dart';
import 'package:domo_server/src/domain/usecase/use_case_domain.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../injector.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth firebaseAuth;
  final AuthUseCaseDomnain authUseCaseDomnain;
  final UserUSerCaseDomain uSerCaseDomain;
  final SharedPrefencesUseCase sharedPrefencesUseCase;
  final RemoteCityUseCase remoteCityUseCase;
  final LocalCityUseCase localCityUseCase;

  AuthBloc({
    required this.remoteCityUseCase,
    required this.localCityUseCase,
    required this.firebaseAuth,
    required this.authUseCaseDomnain,
    required this.uSerCaseDomain,
    required this.sharedPrefencesUseCase,
  }) : super(AuthInitial()) {
    _addData();
    on<OnVerifiedNumber>(_onVerifiedNumber);
    on<OnSendNumber>(_onSendNumber);
    on<OnVerifiedCode>(_onVerifiedCode);
  }

  void _onVerifiedNumber(
      OnVerifiedNumber event, Emitter<AuthState> emitter) async {
    emitter(LoadingAuthState());
    await Future.delayed(const Duration(seconds: 4));
    if (event.number.trim().isEmpty) {
      emitter(ErrorInAuthState(message: kErrorNumberEmpty));
    } else if (event.number.trim().length < 10) {
      emitter(ErrorInAuthState(message: kErrorNumber));
    } else if (!event.number.startsWith("3") &&
        event.number.trim().length < 10) {
      emitter(ErrorInAuthState(message: kErrorNumber));
    } else if (event.number.trim().length == 10) {
      emitter(NextInAuthState());
    }
    emitter(CloseInAuthState());
    emitter(HidenLoadingAuthState());
  }

  void _onSendNumber(OnSendNumber event, Emitter<AuthState> emitter) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+57${event.number}',
      verificationCompleted: (PhoneAuthCredential credential) {
        emit(ShowCode(phoneAuthCredential: credential));
        emit(CloseInAuthState());
      },
      verificationFailed: (FirebaseAuthException firebaseException) {
        String message = "";

        if (firebaseException.code == 'too-many-requests') {
          message = kErrorIntentons;
        }
        if (firebaseException.code == 'invalid-phone-number') {
          message = kFormatoNumero;
        }
        emit(ErrorInAuthState(message: message));
        emit(CloseInAuthState());
      },
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {
        emit(ErrorInAuthState(message: kTimeOut));
        emit(CloseInAuthState());
      },
    );
  }

  void _onVerifiedCode(OnVerifiedCode event, Emitter emitter) async {
    final result = await authUseCaseDomnain.signInWithPhone(
        phoneAuthCredential: event.phoneAuthCredential);
    result.fold((l) {
      emit(ErrorInAuthState(message: 'Error al crear cuenta'));
      emit(CloseInAuthState());
    }, (r) async {
      if (r.user != null) {
        final userExits = await uSerCaseDomain.getUser(id: r.user!.uid);

        bool exits = false;
        userExits.fold((l) {}, (r2) {
          if (r2.uid!.isEmpty) {
            exits = true;
          }else{
            exits = false;
          }
        });

        if (exits) {
          log(" dddddddddddddddddd");

          final result2 = await uSerCaseDomain.createUser(data: {
            "uid": r.user!.uid,
            "active": true,
            "accountComplete": false,
            "phone": event.phone,
          });
          result2.fold((l) {
            emit(ErrorInAuthState(message: 'Error a crear cuenta'));
          }, (r) {
               final d = locator<NotificationUseCase>();
            d.init().then((value) {});
            emit(NextInAuthState());
            emit(CloseInAuthState());
          });
        } else {
          emit(IsLooginState());
          emit(CloseInAuthState());
        }
      }
    });
  }

  Future<bool> getSession() async {
    bool status = false;
    final session = await authUseCaseDomnain.verifySession();
    session.fold((l) {}, (r) async {
      status = r;
    });
    return status;
  }

  void _addData() async {
    int number = 0;

    final flat = await sharedPrefencesUseCase.getKeyInt(key: "dataCache");
    flat.fold((l) {
      number = 0;
    }, (r) {
      number = r;
    });

    if (number == 0) {
      final result = await remoteCityUseCase.getCity();
      result.fold((l) {}, (r) async {
        for (var i = 0; i < r.length; i++) {
          await localCityUseCase.create(data: {
            "id": (i + 1),
            "city": r[i].city,
            "departamento": r[i].departamento,
          });
        }
        await sharedPrefencesUseCase.setKeyInt(key: "dataCache", value: 1);
      });
    }
  }

  Future<void> logAuth()async{
    await authUseCaseDomnain.logOut();

  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:domo_server/injector.dart';
import 'package:domo_server/src/domain/usecase/use_case_domain.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

abstract class NotificationRemoteDataSource {
  Stream<dynamic> foreGround();
  Stream<dynamic> backGround();
  Stream<dynamic> terminated();
  Future<void> init();


  Future<bool> sendNotification(
      {required String message,
      required String token,
      required String title});
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final FirebaseMessaging firebaseMessaging;
  final sharedPreferences = locator<SharedPrefencesUseCase>();
  final authUseCaseDomnain = locator<AuthUseCaseDomnain>();
  static final StreamController _streamController =
      StreamController.broadcast();
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection("token");

  NotificationRemoteDataSourceImpl(this.firebaseMessaging) {
  }

  @override
  Future<void> init() async{
   
    await firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    final token = await firebaseMessaging.getToken();

    final getToken = await sharedPreferences.getKeyString(key: "token");

    getToken.fold((l) {
      log("11111111111111111");
      authUseCaseDomnain.getUserId().then((value) {
        value.fold((l) {
          log("122222222222222222");
        }, (r) {
          log("33333333333333333");
          if (r.isNotEmpty) {
            _ref.doc(r).set({
              "userId": r,
              "token": token,
            }).then((value) {
              log("wwwwwwwwwwwww");
              sharedPreferences.setKeyString(key: "token", value: token!);
            }).catchError((e){
              log("gggggggggggggg");
            });
          }
        });
      });
    }, (r) {
      authUseCaseDomnain.getUserId().then((value) {
        value.fold((l) {}, (r) {
          if (r.isNotEmpty) {
            _ref.doc(r).set({
              "userId": r,
              "token": token,
            }).then((value) {
              sharedPreferences.setKeyString(key: "token", value: token!);
            });
          }
        });
      });
    });

 
    log(token!);
    try {
      FirebaseMessaging?.onBackgroundMessage(_background);
      FirebaseMessaging.onMessage.listen(_onbackground);
      FirebaseMessaging.onMessageOpenedApp.listen(abirMessage);
    } on FirebaseException catch (e) {
      Future.error('Error $e');
  }
  }

  static Future<void> _background(RemoteMessage message) async {
    _streamController.add(message.notification?.title ?? 'no titulo');
    log("1111111111111");
    //cuando la app esta en segundo en plano
  }

  static Future<void> _onbackground(RemoteMessage message) async {
    //Cuando la app esta abierta
    _streamController.add(message.notification?.title ?? 'no titulo');
    log("2222222222222222 ${ message.notification!.body}");

  }

  static Future<void> abirMessage(RemoteMessage message) async {
// cuando la app esta terminada

    _streamController.add(message.notification?.title ?? 'no titulo');
    log("333333333333333");

  }

  @override
  Stream<dynamic> backGround() async* {
    try {} catch (e) {
      Future.error(e);
    }
    yield [];
  }
//305
  @override
  Stream<dynamic> foreGround() async* {
    try {} catch (e) {
      Future.error(e);
    }
    yield [];
  }

  @override
  Stream<dynamic> terminated() async* {
    try {} catch (e) {
      Future.error(e);
    }
    yield [];
  }

  void dispose() {
    _streamController.close();
  }

  @override
  Future<bool> sendNotification(
      {required String  message,
      required String token,
      required String title}) async {
    final dio = Dio();
    String _header =
        "key=AAAAdza5YOQ:APA91bHjzPvZsis6OO_B6yqtIFWTqmaKRYC3GlcE-LQ1oAoeCI8vr9wC4EvuzEcn0aAhYGaiHKoDz3U-sa3lq2Cn1dG1j1EjjnXdk2lgGL7vNh9zUH7SDKRKt7E9pWvqyZPUsspe4gNj";
    
    try {
      String url = 'https://fcm.googleapis.com/fcm/send';
      Map<String, dynamic> _body = {
        'to': token,
        'priority': 'high',
        'notification': {
          'title': title,
          'body': message,
        }
      };
      final sendMessage = await http.post(Uri.parse(url),
      body: jsonEncode(_body),
         headers: {
            'Content-Type': 'application/json',
            "Authorization": _header,
          });
      log("${sendMessage.body} ${sendMessage.statusCode}");    
      return true;
    } on FirebaseException catch (e) {
      log("Push error $e");
    throw UnimplementedError();
    }
  }
}

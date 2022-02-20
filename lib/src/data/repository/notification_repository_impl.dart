import 'package:domo_server/src/data/datasource/data_source_data.dart';
import 'package:domo_server/src/domain/repository/repository_domain.dart';

class NotificationRepositoryImpl implements NotificationRepositoryDomain {
  final NotificationRemoteDataSource firebaseNotificationRemote;

  NotificationRepositoryImpl(this.firebaseNotificationRemote);
  @override
  Stream<dynamic> backGround() => firebaseNotificationRemote.backGround();

  @override
  Stream<dynamic> foreGround() => firebaseNotificationRemote.foreGround();

  @override
  Stream<dynamic> terminated() => firebaseNotificationRemote.terminated();

  @override
  Future<bool> sendNotification(
          {required String message ,
          required String token,
          required String title}) =>
      firebaseNotificationRemote.sendNotification(
        message: message,
        token: token,
        title: title,
      );
        @override
  Future<void> init() =>firebaseNotificationRemote.init();
}

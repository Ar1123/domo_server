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
          {required Map<String, dynamic> body,
          required String token,
          required String title}) =>
      firebaseNotificationRemote.sendNotification(
        body: body,
        token: token,
        title: title,
      );
}

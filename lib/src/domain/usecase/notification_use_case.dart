
import '../repository/repository_domain.dart';

class NotificationUseCase {
  final NotificationRepositoryDomain notificationRepositoryDomain;

  NotificationUseCase(this.notificationRepositoryDomain);

  Stream<dynamic> foreGround() => notificationRepositoryDomain.foreGround();
  Stream<dynamic> backGround() => notificationRepositoryDomain.backGround();
  Stream<dynamic> terminated() => notificationRepositoryDomain.terminated();
  Future<bool> sendNotification({
    required Map<String, dynamic> body,
    required String token,
    required String title,
  })=> notificationRepositoryDomain.sendNotification(body: body, token: token, title: title);
}

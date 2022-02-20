
import '../repository/repository_domain.dart';

class NotificationUseCase {
  final NotificationRepositoryDomain notificationRepositoryDomain;

  NotificationUseCase(this.notificationRepositoryDomain);

  Stream<dynamic> foreGround() => notificationRepositoryDomain.foreGround();
  Stream<dynamic> backGround() => notificationRepositoryDomain.backGround();
  Stream<dynamic> terminated() => notificationRepositoryDomain.terminated();
      Future<void> init()=> notificationRepositoryDomain.init();

  Future<bool> sendNotification({
    required String message,
    required String token,
    required String title,
  })=> notificationRepositoryDomain.sendNotification(message: message, token: token, title: title);
}

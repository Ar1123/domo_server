abstract class NotificationRepositoryDomain {
  Stream<dynamic> foreGround();
  Stream<dynamic> backGround();
  Stream<dynamic> terminated();
  Future<bool> sendNotification({
    required Map<String, dynamic> body,
    required String token,
    required String title,
  });
}

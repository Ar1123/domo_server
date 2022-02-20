import 'package:domo_server/injector.dart';
import 'package:domo_server/src/config/routes/routes.dart';
import 'package:domo_server/src/domain/usecase/use_case_domain.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initLocator();
 final d = locator<NotificationUseCase>();
 await d.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
      title: 'Domo Server',
      debugShowCheckedModeBanner: false,
      initialRoute: 'authPhone',
      routes: getRoutes(),
    );
  }
}
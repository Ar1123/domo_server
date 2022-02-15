import 'package:domo_server/src/presentation/pages/pages.dart';

getRoutes() => {
      'authPhone': (_) => AuthPhonePage(),
      // 'selectUserType': (_) => SelectUserType(),
      'homePage':(_)=>HomePage(),
      'profilePage':(_)=>TabProfilePage()
    };

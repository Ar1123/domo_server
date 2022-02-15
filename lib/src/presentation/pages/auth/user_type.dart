// import 'package:flutter/material.dart';

// import '../../../config/style/style.dart';
// import '../../../core/constant/asset_images.dart';
// import '../../../core/constant/words.dart';
// import '../../../domain/entities/user_entities.dart';
// import '../../../injector.dart';
// import '../../blocs/blocs.dart';
// import '../../widgets/widgets.dart';

// class SelectUserType extends StatefulWidget {
//   SelectUserType({Key? key}) : super(key: key);

//   @override
//   State<SelectUserType> createState() => _SelectUserTypeState();
// }

// class _SelectUserTypeState extends State<SelectUserType> {
//   final userBloc = locator<UserBloc>();

//   bool card1 = false;

//   bool card2 = false;
//   bool loading = false;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: backGroundColor,
//         body: FutureBuilder<UserEntities>(
//             future: userBloc.getUser(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 if (snapshot.data?.typUser != 0) {
//                   Future.delayed(Duration(seconds: 1), () {
//                     Navigator.of(context).pushNamedAndRemoveUntil(
//                         'homePage', (Route<dynamic> route) => false,
//                         arguments: {
//                           "userType": snapshot.data?.typUser,
//                         });
//                   });
//                   return Container(
//                       height: size.height,
//                       child: Center(
//                         child: CircularProgressIndicator(),
//                       ));
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(
//                             left: size.width * .1,
//                             right: size.width * .1,
//                             top: size.height * .1),
//                         child: RichText(
//                           textAlign: TextAlign.center,
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: ktextUserType,
//                                 style: textStyle(
//                                   color: colorText,
//                                   size: size.height * .021,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: kDomo,
//                                 style: textStyle(
//                                   color: colorText,
//                                   size: size.height * .021,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * .1,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _cardUSerType(
//                               size: size,
//                               text: kTextEmploye,
//                               img: kImageEmploye,
//                               selected: card1,
//                               action: () {
//                                 card1 = true;
//                                 card2 = false;
//                                 setState(() {});
//                               }),
//                           SizedBox(
//                             width: size.width * .04,
//                           ),
//                           _cardUSerType(
//                               size: size,
//                               text: kTextClient,
//                               img: kImageClient,
//                               selected: card2,
//                               action: () {
//                                 card1 = false;
//                                 card2 = true;
//                                 setState(() {});
//                               }),
//                         ],
//                       ),
//                       SizedBox(
//                         height: size.height * .1,
//                       ),
//                       (loading)
//                           ? Center(
//                               child: CircularProgressIndicator(),
//                             )
//                           : ButtonWidget(
//                               backGroundColor: colorText,
//                               borderColor: colorText,
//                               textColor: whiteColor,
//                               text: 'Continuar',
//                               action: () async {
//                                 if (!card1 && !card2) {
//                                   custonTopSnackbar(
//                                     context: context,
//                                     message: "Selecciona un tipo de usuario",
//                                     type: Types.error,
//                                   );
//                                 } else {
//                                   if (card1) {
//                                     loading = true;
//                                     setState(() {});
//                                     final result =
//                                         await userBloc.udateUser(data: {
//                                       "typeUser": 1,
//                                     });
//                                     if (result) {
//                                       loading = false;
//                                       Navigator.of(context)
//                                           .pushNamedAndRemoveUntil('homePage',
//                                               (Route<dynamic> route) => false,
//                                               arguments: {
//                                             "userType": snapshot.data?.typUser,
//                                           });
//                                     } else {
//                                       setState(() {
//                                         loading = false;
//                                       });
//                                     }
//                                   }
//                                   if (card2) {
//                                     loading = true;
//                                     setState(() {});
//                                     final result =
//                                         await userBloc.udateUser(data: {
//                                       "typeUser": 2,
//                                     });
//                                     if (result) {
//                                       loading = false;
//                                       Navigator.of(context)
//                                           .pushNamedAndRemoveUntil('homePage',
//                                               (Route<dynamic> route) => false,
//                                               arguments: {
//                                             "userType": snapshot.data?.typUser,
//                                           });
//                                     } else {
//                                       setState(() {
//                                         loading = false;
//                                       });
//                                     }
//                                   }
//                                 }
//                               },
//                             ),
//                     ],
//                   );
//                 }
//               } else {
//                 return Container(
//                     height: size.height,
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ));
//               }
//             }),
//       ),
//     );
//   }

//   Widget _cardUSerType({
//     required Size size,
//     required String text,
//     required String img,
//     required bool selected,
//     required Function() action,
//   }) =>
//       GestureDetector(
//         onTap: action,
//         child: Column(
//           children: [
//             Container(
//               height: size.height * .2,
//               width: size.width * .4,
//               decoration: BoxDecoration(
//                   color: blueColorTwo,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: colorText,
//                       offset: (selected) ? Offset(0, 5) : Offset(0, 0),
//                       blurRadius: (selected) ? 2 : 0,
//                     )
//                   ],
//                   image: DecorationImage(image: AssetImage(img))),
//             ),
//             SizedBox(
//               height: size.height * .02,
//             ),
//             Text(
//               text,
//               style: textStyle(
//                 color: colorText,
//                 size: size.height * .02,
//               ),
//             )
//           ],
//         ),
//       );
// }

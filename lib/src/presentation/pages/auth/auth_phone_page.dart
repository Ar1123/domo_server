import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injector.dart';
import '../../../config/style/style.dart';
import '../../../core/constant/asset_images.dart';
import '../../../core/constant/words.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../widgets/widgets.dart';
import 'verification_code.dart';

class AuthPhonePage extends StatefulWidget {
  const AuthPhonePage({Key? key}) : super(key: key);

  @override
  _AuthPhonePageState createState() => _AuthPhonePageState();
}

class _AuthPhonePageState extends State<AuthPhonePage> {
  final TextEditingController _numberController = TextEditingController();
  final authBloc = locator<AuthBloc>();
  bool loading = false;

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: BlocProvider(
      create: (context) => authBloc,
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: FutureBuilder<bool>(
            future: authBloc.getSession(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        'homePage', (Route<dynamic> route) => false);
                  });
                  return Container(
                      height: size.height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * .05,
                        ),
                        SizedBox(
                          width: size.width,
                          height: size.height * .2,
                          child: Image(
                            image: AssetImage(kImageLogo),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .07,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            ktextLogin,
                            textAlign: TextAlign.center,
                            style: textStyle(
                              color: colorText,
                              size: size.height * .03,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: size.height * .04,
                            left: size.width * .06,
                            right: size.width * .06,
                          ),
                          child: InputWidget(
                            labeltext: ktextInputLogin,
                            onchanged: (e) {},
                            textInputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            textEditingController: _numberController,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          height: size.height * .07,
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return BlocListener<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state is LoadingAuthState) {
                                  loading = true;
                                }
                                if (state is ErrorInAuthState) {
                                  loading = false;
                                  custonTopSnackbar(
                                    context: context,
                                    message: state.message!,
                                    type: Types.error,
                                  );
                                }
                                if (state is NextInAuthState) {
                                  loading = false;
                                  custonTopSnackbar(
                                    context: context,
                                    message:
                                        "$kinfoAuth ${_numberController.text}",
                                    type: Types.info,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          VerificationCodePage(
                                        number: _numberController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: (loading)
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ButtonWidget(
                                      backGroundColor: colorText,
                                      borderColor: colorText,
                                      textColor: whiteColor,
                                      text: kbtnLogin,
                                      action: () {
                                        context.read<AuthBloc>().add(
                                              OnVerifiedNumber(
                                                number: _numberController.text
                                                    .trim(),
                                              ),
                                            );
                                      },
                                    ),
                            );
                          },
                        ),
                        SizedBox(
                          height: size.height * .07,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * .1,
                          ),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                _textSpan(kLinesTermsOne, size),
                                TextSpan(
                                  text: kLinesTermsTwo,
                                  style: textStyle(
                                    color: colorText,
                                    size: size.height * .02,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                _textSpan(kLinesTermsThree, size),
                                TextSpan(
                                  text: kLinesTermsFour,
                                  style: textStyle(
                                    color: colorText,
                                    size: size.height * .02,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                _textSpan(kLinesTermsFive, size),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return Container(
                  height: size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      ),
    ));
  }

  TextSpan _textSpan(String text, Size size) => TextSpan(
        text: text,
        style: textStyle(
          color: colorText,
          size: size.height * .02,
          fontWeight: FontWeight.normal,
        ),
      );
}

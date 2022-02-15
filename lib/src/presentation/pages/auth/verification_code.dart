import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../injector.dart';
import '../../../config/style/style.dart';
import '../../../core/constant/words.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../widgets/widgets.dart';

class VerificationCodePage extends StatefulWidget {
  VerificationCodePage({Key? key, required this.number}) : super(key: key);
  final String number;

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final authBloc = locator<AuthBloc>();
  PhoneAuthCredential? phoneAuthCredential;

  bool loading = true;
  final TextEditingController _codeController = TextEditingController();
  @override
  void initState() {
    _sendData();
    super.initState();
  }

  void _sendData() {
    authBloc.add(OnSendNumber(number: widget.number));
    Future.delayed(Duration(seconds: 8), () {
      loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocProvider(
        create: (context) => authBloc,
        child: Scaffold(
          backgroundColor: backGroundColor,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width * .04,
                          top: size.height * .1,
                          right: size.width * .3),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: ktextInfo,
                              style: textStyle(
                                color: colorText,
                                size: size.height * .023,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: widget.number,
                              style: textStyle(
                                color: colorText,
                                size: size.height * .023,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: size.width * .1,
                        right: size.width * .1,
                        top: size.height * .15,
                      ),
                      child: PinCodeTextField(
                        appContext: context,
                        controller: _codeController,
                        pinTheme: PinTheme(
                          activeColor: colorText,
                          inactiveColor: colorText,
                        ),
                        length: 6,
                        onChanged: (String value) {},
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '¿No recibiste el código? ',
                            style: textStyle(
                              color: colorText,
                              size: size.height * .02,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: 'Reenviar ',
                            style: textStyle(
                              color: colorText,
                              size: size.height * .02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * .1,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is ShowCode) {
                              loading = false;
                              phoneAuthCredential = state.phoneAuthCredential;
                              _codeController.value = _codeController.value
                                  .copyWith(
                                      text: state.phoneAuthCredential!.smsCode);
                            }
                            if (state is NextInAuthState) {
                              loading = false;
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'homePage',
                                  (Route<dynamic> route) => false);
                            }
                            if (state is IsLooginState) {
                              loading = false;
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'homePage',
                                  (Route<dynamic> route) => false);
                            }
                            if (state is ErrorInAuthState) {
                              custonTopSnackbar(
                                context: context,
                                message: state.message!,
                                type: Types.error,
                              );
                            }
                          },
                          child: ButtonWidget(
                            backGroundColor: colorText,
                            borderColor: colorText,
                            textColor: whiteColor,
                            text: 'Verificar',
                            action: () {
                              loading = true;
                              setState(() {});
                              if (phoneAuthCredential != null) {
                                context.read<AuthBloc>().add(OnVerifiedCode(
                                      phoneAuthCredential: phoneAuthCredential!,
                                      phone: widget.number,
                                    ));
                                return;
                              }
                              loading = false;
                              setState(() {});
                              custonTopSnackbar(
                                context: context,
                                message: "Upsss, error al crear cuenta",
                                type: Types.error,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                (loading)
                    ? Container(
                        height: size.height,
                        color: Colors.black.withOpacity(.5),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

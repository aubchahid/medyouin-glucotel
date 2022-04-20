import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/auth.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/views/auth/sign_up.dart';
import 'package:glucotel/widgets/text_field.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Tools().showAlertDialogExit(context),
      child: LoadingOverlay(
        isLoading: _isLoading,
        color: Theme.of(context).primaryColorDark,
        progressIndicator: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 6.0,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  40.verticalSpace,
                  Center(
                    child: Image.asset(
                      'assets/images/logo_color.png',
                      width: 220.w,
                    ),
                  ),
                  30.verticalSpace,
                  Text(
                    'Content de te revoir',
                    style: TextStyle(
                      fontFamily: "CairoBold",
                      fontSize: 16.sp,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'Utilisez vos identifiants pour vous connecter à votre compte ci-dessous.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "CairoRegular",
                        fontSize: 14.sp,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  InputTextField(
                    hintText: "Entrez votre adresse e-mail",
                    type: TextInputType.emailAddress,
                    controller: _email,
                    icon: Boxicons.bxs_envelope,
                  ),
                  10.verticalSpace,
                  InputTextField(
                    hintText: "Entrez votre mot de passe",
                    isPassword: true,
                    type: TextInputType.text,
                    controller: _password,
                    icon: Boxicons.bxs_lock_alt,
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Mot de passe oubliée?',
                        style: TextStyle(
                          fontFamily: "CairoBold",
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Center(
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        if (await Tools().loginFormValidator(
                            _email.text.replaceAll(' ', ''),
                            _password.text,
                            context)) {
                          await Auth().emailSignIn(
                              _email.text.replaceAll(' ', ''),
                              _password.text,
                              context);
                          setState(() => _isLoading = false);
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      child: Container(
                        height: 55.h,
                        width: 220.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Se connecter",
                          style: TextStyle(
                            fontFamily: 'CairoBold',
                            fontSize: 14.sp,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Text(
                    'Ou connectez-vous avec',
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                      fontSize: 14.sp,
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.4),
                    ),
                  ),
                  20.verticalSpace,
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        Auth().googleSignIn(context).then((value) {
                          if (!value) {
                            setState(() {
                              _isLoading = false;
                            });
                            Tools().showDesachievementView(
                                context,
                                "Message d'erreur",
                                "Veuillez réessayer dans quelques secondes, désolé pour cela");
                          }
                        });
                      } catch (e) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    child: Container(
                      height: 65.h,
                      width: 65.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: const Color.fromRGBO(250, 20, 20, 1),
                      ),
                      child: Icon(
                        Boxicons.bxl_google,
                        color: Colors.white,
                        size: 45.h,
                      ),
                    ),
                  ),
                  40.verticalSpace,
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const SignUpScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 55.h,
                      child: Text(
                        'Vous n’avez pas de compte? s’inscrire',
                        style: TextStyle(
                          fontFamily: 'CairoBold',
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

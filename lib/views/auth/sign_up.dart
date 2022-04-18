import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/auth.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/widgets/text_field.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        isLoading: _isLoading,
        color: Theme.of(context).primaryColorDark,
        progressIndicator: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 6.0,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
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
                  'Bienvenue!',
                  textAlign: TextAlign.center,
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
                    'Créez votre compte chez nous pour avoir un accès facile et rapide.',
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
                  hintText: "Entrez votre nom complete",
                  type: TextInputType.text,
                  controller: _fullname,
                  icon: Boxicons.bxs_user,
                ),
                10.verticalSpace,
                InputTextField(
                  hintText: "Entrez votre numéro de téléphone",
                  type: TextInputType.phone,
                  controller: _phoneNo,
                  icon: Boxicons.bxs_phone,
                ),
                10.verticalSpace,
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
                  child: Text(
                    'En cliquant sur Créer mon compte, je déclare avoir lu et compris les termes et conditions.',
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                      fontSize: 14.sp,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                20.verticalSpace,
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (await Tools().registerFormValidator(
                          _fullname.text,
                          _phoneNo.text,
                          _email.text,
                          _password.text,
                          context)) {
                        setState(() {
                          _isLoading = true;
                        });
                        await Auth()
                            .emailSignUp(_fullname.text, _phoneNo.text,
                                _email.text, _password.text, context)
                            .then((value) {
                          if (value == false) {
                            setState(() {
                              _isLoading = value;
                            });
                          }
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
                        "Créer mon compte",
                        style: TextStyle(
                          fontFamily: 'CairoBold',
                          fontSize: 14.sp,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
                40.verticalSpace,
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 55.h,
                    child: Text(
                      'Vous avez déjà un compte? Se Connecter',
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
    );
  }
}

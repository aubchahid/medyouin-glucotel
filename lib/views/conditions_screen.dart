import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/views/onboarding_screen.dart';
import 'package:page_transition/page_transition.dart';

class ConditionsScreen extends StatefulWidget {
  const ConditionsScreen({Key? key}) : super(key: key);

  @override
  State<ConditionsScreen> createState() => _ConditionsScreenState();
}

class _ConditionsScreenState extends State<ConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Tools().showAlertDialogExit(context),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.verticalSpace,
                Center(
                  child: Image.asset(
                    'assets/images/logo_color.png',
                    width: 220.w,
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Clause de non-responsabilité',
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                      fontSize: 16.sp,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Les informations et les données statistiques fournies par l'application GLUCOTEL sont seulement pour vous aider à mieux comprendre le diabète. Toutes les décisions concernant le traitement de votre diabète doivent être prises après consultation avec votre médecin traitant.",
                    style: TextStyle(
                      fontFamily: 'CairoRegular',
                      fontSize: 14.sp,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Condition d'utilisation et  confidentialité",
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                      fontSize: 16.sp,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Nous prenons les mesures requises pour protéger vos informations personnelles. Celles-ci comprennent la mise en place de processus et procédures visant à minimiser l'accès non autorisé à vos informations ou leur divulgation et à leur hébergement sur des serveurs sécurisés. Nous ne pouvons cependant pas garantir l'élimination totale du risque d'usage abusif de vos informations personnelles par des intrus. Protégez les mots de passe de vos comptes et ne les communiquez à personne. Vous devez nous contacter immédiatement si vous découvrez une utilisation non autorisée de votre mot de passe ou toute autre violation de sécurité.",
                    style: TextStyle(
                      fontFamily: 'CairoRegular',
                      fontSize: 14.sp,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                20.verticalSpace,
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const OnBoardingScreen(),
                        ),
                      );
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
                        'Suivant',
                        style: TextStyle(
                          fontFamily: 'CairoBold',
                          fontSize: 14.sp,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
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

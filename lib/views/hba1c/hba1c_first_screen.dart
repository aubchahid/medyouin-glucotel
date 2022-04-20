// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/views/hba1c/hba1c_resultat_screen.dart';
import 'package:page_transition/page_transition.dart';

class HBA1CFirstScreen extends StatefulWidget {
  const HBA1CFirstScreen({Key? key}) : super(key: key);

  @override
  State<HBA1CFirstScreen> createState() => _HBA1CFirstScreenState();
}

class _HBA1CFirstScreenState extends State<HBA1CFirstScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Outil d'estimation de l'HBA1C (eA1c)",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 18.sp,
                        fontFamily: 'CairoSemiBold',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/Asset 1.png',
                      height: 280.h,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: Text(
                      "L'eA1c calculée est just une estimation basée sur la glycémie moyenne calculée à partir des valuers que vous avez saisie.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 16.sp,
                        fontFamily: 'CairoSemiBold',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Outil d'estimation de l'HBA1C (eA1c)",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 18.sp,
                        fontFamily: 'CairoSemiBold',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/Asset 2.png',
                      height: 280.h,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Afin de calculer votre ",
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 16.sp,
                          fontFamily: 'CairoSemiBold',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'eA1c',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 16.sp,
                              fontFamily: 'CairoBold',
                            ),
                          ),
                          TextSpan(
                            text: ' vous avez besoin de remplir ',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 16.sp,
                              fontFamily: 'CairoSemiBold',
                            ),
                          ),
                          TextSpan(
                            text: 'au moins 3 mesures',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.sp,
                              fontFamily: 'CairoBold',
                            ),
                          ),
                          TextSpan(
                            text: ' de glycémies quotidiennes durant les ',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 16.sp,
                              fontFamily: 'CairoSemiBold',
                            ),
                          ),
                          TextSpan(
                            text: '7 prochains jours.',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.sp,
                              fontFamily: 'CairoBold',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Outil d'estimation de l'HBA1C (eA1c)",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 18.sp,
                        fontFamily: 'CairoSemiBold',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/Asset 3.png',
                      height: 280.h,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: Text(
                      "Ne vous inquiétez pas vous serez notifié tout au long de la journée durant les 7 prochains jours.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 16.sp,
                        fontFamily: 'CairoSemiBold',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Outil d'estimation de l'HBA1C (eA1c)",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 18.sp,
                        fontFamily: 'CairoSemiBold',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/onBoarding_3.png',
                      height: 280.h,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: Text(
                      "Cliquez sur le button de 'Démarrer' pour démarrer l'outil d'estimation de l'HBA1C (eA1c)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 16.sp,
                        fontFamily: 'CairoSemiBold',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Boxicons.bx_chevron_left,
              size: 35.h,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: 80.h,
          title: Center(
            child: Image.asset(
              "assets/images/logo_white.png",
              width: 140.w,
            ),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20.0.w),
              child: Icon(
                Boxicons.bx_chevron_left,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (i, index) {
                  return _list[currentIndex];
                },
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  4,
                  (index) => buildDot(index, context),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Row(
                children: [
                  currentIndex != 0
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              if (currentIndex != 0) {
                                currentIndex--;
                              }
                            });
                          },
                          child: Container(
                            height: 55.h,
                            width: 55.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Boxicons.bxs_chevron_left,
                              size: 25.w,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Container(),
                  const Spacer(),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        if (currentIndex != _list.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        } else if (currentIndex == _list.length - 1) {
                          await SessionManager().set('hba1c', 'active');
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: const HBA1CResultat(),
                              type: PageTransitionType.leftToRight,
                            ),
                          );
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
                          currentIndex != 3 ? "Suivant" : "Démarrer",
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
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.h,
      width: currentIndex == index ? 40.w : 15.w,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.3),
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/views/blogsScreens/blog_screen.dart';
import 'package:glucotel/views/dieteScreen/imc_resultat_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class DieteCalculatriceScreen extends StatefulWidget {
  const DieteCalculatriceScreen({Key? key}) : super(key: key);

  @override
  State<DieteCalculatriceScreen> createState() =>
      _DieteCalculatriceScreenState();
}

class _DieteCalculatriceScreenState extends State<DieteCalculatriceScreen> {
  final TextEditingController _size = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  double weight = 0, size = 0, iniSize = 0, imcResult = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Boxicons.bxs_chevron_left,
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
                Boxicons.bxs_chevron_left,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
          elevation: 0,
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            20.verticalSpace,
            Center(
              child: Text(
                'IMC Calculatrice',
                style: TextStyle(
                  fontFamily: 'CairoBold',
                  fontSize: 18.sp,
                ),
              ),
            ),
            20.verticalSpace,
            Center(
              child: Text(
                'IMC = L’indice de masse corporelle',
                style: TextStyle(
                  fontFamily: 'CairoSemiBold',
                  fontSize: 16.sp,
                  height: 1.4,
                ),
              ),
            ),
            20.verticalSpace,
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'L’indice de masse corporelle (IMC) permet d’évaluer rapidement votre corpulence simplement avec votre poids et votre taille, quel que soit votre sexe. Calculez rapidement votre IMC et découvrez dans quelle catégorie vous vous situez.',
                  style: TextStyle(
                    fontFamily: 'CairoSemiBold',
                    fontSize: 14.sp,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            20.verticalSpace,
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'L’indice de masse corporelle (IMC) est le seul indice validé par l’Organisation mondiale de la santé pour évaluer la corpulence d’un individu et donc les éventuels risques pour la santé. L’IMC permet de déterminer si l’on est situation de maigreur, de surpoids ou d’obésité par exemple.',
                  style: TextStyle(
                    fontFamily: 'CairoSemiBold',
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: _size,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      style: TextStyle(
                        fontFamily: "CairoSemiBold",
                        fontSize: 14.sp,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Taille',
                        hintStyle: TextStyle(
                          fontFamily: "CairoRegular",
                          fontSize: 14.sp,
                        ),
                        suffixIcon: Container(
                          width: 15,
                          alignment: Alignment.center,
                          child: Text(
                            'cm',
                            style: TextStyle(
                              fontFamily: "CairoSemiBold",
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: const Color.fromRGBO(231, 230, 235, 1),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: _weight,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      style: TextStyle(
                        fontFamily: "CairoSemiBold",
                        fontSize: 14.sp,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Poids',
                        hintStyle: TextStyle(
                          fontFamily: "CairoRegular",
                          fontSize: 14.sp,
                        ),
                        suffixIcon: Container(
                          width: 15,
                          alignment: Alignment.center,
                          child: Text(
                            'kg',
                            style: TextStyle(
                              fontFamily: "CairoSemiBold",
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: const Color.fromRGBO(231, 230, 235, 1),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
            20.verticalSpace,
            Center(
              child: InkWell(
                onTap: () async {
                  if (_size.text != '' && _weight.text != '') {
                    weight = double.parse(_weight.text);
                    iniSize = size = double.parse(_size.text);
                    size = size / 100;
                    size = size * size;
                    imcResult = weight / size;
                    Navigator.push(
                      context,
                      PageTransition(
                        child: ImcResultatScreens(
                          resultat: imcResult,
                          size: iniSize.toString(),
                          weight: weight.toString(),
                        ),
                        type: PageTransitionType.rightToLeft,
                      ),
                    );
                    _size.text = '';
                    _weight.text = '';
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
                    "Calculer",
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
            Center(
              child: InkWell(
                onTap: () {
                  pushNewScreen(
                    context,
                    screen: const BlogsScreen(),
                    pageTransitionAnimation: PageTransitionAnimation.slideRight,
                  );
                },
                child: Text(
                  "Plus d'information",
                  style: TextStyle(
                    fontFamily: "CairoBold",
                    fontSize: 14.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}

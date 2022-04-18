// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/Tools.dart';
import 'package:glucotel/model/user.dart';

class IndexGlycemiqueScreen extends StatefulWidget {
  const IndexGlycemiqueScreen({Key? key}) : super(key: key);

  @override
  State<IndexGlycemiqueScreen> createState() => _IndexGlycemiqueScreenState();
}

class _IndexGlycemiqueScreenState extends State<IndexGlycemiqueScreen> {
  User? currentUser;
  double cal = 0;
  final TextEditingController _weight = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Tools().getCurrentUser().then((value) {
        setState(() {
          currentUser = value;
          cal = ((double.parse(currentUser!.weight) * 14.2) + 593);
          _weight.text = currentUser!.weight.toString();
        });
      });
    }
  }

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
          children: [
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                'Dépense énergétique calculatrice',
                style: TextStyle(
                  fontFamily: 'CairoBold',
                  fontSize: 18.sp,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                'Votre métabolisme de base est :',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 16.sp,
                  fontFamily: 'CairoSemiBold',
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                cal.toStringAsFixed(0) + ' Calories',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 22.sp,
                  fontFamily: 'CairoBold',
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  cal.toStringAsFixed(0) +
                      " : C’est ce que votre corps dépense comme énergie, par jour, lorsqu'il est entièrement au repos. Vous dépensez donc un peu plus d'énergie que cela selon votre activité physique.",
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
              child: SizedBox(
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
                      fontFamily: "CairoSemiBold",
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
                    fillColor: const Color.fromRGBO(235, 235, 235, 1),
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
            ),
            20.verticalSpace,
            Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    cal = (double.parse(_weight.text) * 14.2) + 593;
                  });
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Le Tableau ci-dessous vous permet d’estimer votre dépense énergétique journalière selon votre niveau d’activité.',
                style: TextStyle(
                  fontFamily: 'CairoSemiBold',
                  fontSize: 14.sp,
                ),
              ),
            ),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 205, 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        'Sédentaire',
                        style: TextStyle(
                          fontFamily: 'CairoBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Presque aucun exercice quotidien.',
                        style: TextStyle(
                          fontFamily: 'CairoSemiBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Votre dépense énergétique : ' +
                            (cal * 1.2).toStringAsFixed(0) +
                            ' Calories',
                        style: TextStyle(
                          fontFamily: 'CairoSemiBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(225, 251, 229, 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        'Légèrement actif',
                        style: TextStyle(
                          fontFamily: 'CairoBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Vous faites parfois des exercices physiques.',
                        style: TextStyle(
                          fontFamily: 'CairoSemiBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Votre dépense énergétique : ' +
                            (cal * 1.375).toStringAsFixed(0) +
                            ' Calories',
                        style: TextStyle(
                          fontFamily: 'CairoSemiBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(204, 252, 209, 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        'Actif',
                        style: TextStyle(
                          fontFamily: 'CairoBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Vous faites régulièrement des exercices physiques.',
                        style: TextStyle(
                          fontFamily: 'CairoSemiBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Votre dépense énergétique : ' +
                            (cal * 1.55).toStringAsFixed(0) +
                            ' Calories',
                        style: TextStyle(
                          fontFamily: 'CairoSemiBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(162, 254, 173, 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        'Très actif',
                        style: TextStyle(
                          fontFamily: 'CairoBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Vous faites quotidiennement des exercices physiques.',
                        style: TextStyle(
                          fontFamily: 'CairoSemiBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Votre dépense énergétique : ' +
                            (cal * 1.725).toStringAsFixed(0) +
                            ' Calories',
                        style: TextStyle(
                          fontFamily: 'CairoSemiBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(80, 238, 84, 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        'Extrêmement actif',
                        style: TextStyle(
                          fontFamily: 'CairoBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Vous êtes un grand sportif / votre travail est extrêmement physique.',
                        style: TextStyle(
                          fontFamily: 'CairoSemiBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Votre dépense énergétique : ' +
                            (cal * 1.9).toStringAsFixed(0) +
                            ' Calories',
                        style: TextStyle(
                          fontFamily: 'CairoSemiBold',
                          fontSize: 14.sp,
                          height: 1.4,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            25.verticalSpace,
          ],
        ),
      ),
    );
  }
}

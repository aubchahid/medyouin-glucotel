import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/mainScreens/main_screen.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';

class CompleteProfileScreenSecond extends StatefulWidget {
  const CompleteProfileScreenSecond({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreenSecond> createState() =>
      _CompleteProfileScreenSecondState();
}

class _CompleteProfileScreenSecondState
    extends State<CompleteProfileScreenSecond> {
  TextEditingController glycemiePreMealT1 = TextEditingController();
  TextEditingController glycemiePreMealT2 = TextEditingController();
  TextEditingController glycemiePreMealT3 = TextEditingController();

  TextEditingController glycemiePostMealT1 = TextEditingController();
  TextEditingController glycemiePostMealT2 = TextEditingController();
  TextEditingController glycemiePostMealT3 = TextEditingController();

  TextEditingController stepsPerDay = TextEditingController();
  TextEditingController hba1c = TextEditingController();

  bool _loading = false, isSuccess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LoadingOverlay(
          isLoading: _loading,
          color: Theme.of(context).primaryColorDark,
          progressIndicator: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
            strokeWidth: 6.0,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          child: Column(
            children: [
              Container(
                height: 145.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80.h,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Boxicons.bxs_chevron_left,
                                size: 40.h,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Image.asset(
                              'assets/images/logo_white.png',
                              width: 120.w,
                            ),
                            const Spacer(),
                            Icon(
                              Boxicons.bxs_chevron_left,
                              size: 40.h,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Complète votre profile',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontFamily: 'CairoSemiBold',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              15.verticalSpace,
              SizedBox(
                height: 35.h,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Container(
                        height: 35.h,
                        width: 35.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(360),
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'CairoBold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 5.h,
                        width: 210.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(360),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 35.h,
                        width: 35.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(360),
                        ),
                        child: Text(
                          '2',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'CairoBold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              15.verticalSpace,
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        'Nous vous conseillons de saisir les valeurs si vous les avez déjà, sinon, notre système utilisera les valeurs par défault.',
                        style: TextStyle(
                          fontFamily: "CairoSemiBold",
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Card(
                        shadowColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              10.verticalSpace,
                              Container(
                                height: 45.h,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset("assets/images/image_1.png"),
                              ),
                              10.verticalSpace,
                              Container(
                                height: 20.h,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: Text(
                                  'Glycémies avants repas (hors petit-déjeuner)',
                                  style: TextStyle(
                                    fontFamily: "CairoSemiBold",
                                    fontSize: 14.h,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              ),
                              15.verticalSpace,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  height: 35.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 35.h,
                                        width: 85.w,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: glycemiePreMealT1,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: "CairoSemiBold",
                                            fontSize: 14.sp,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '0.69',
                                            hintStyle: TextStyle(
                                              fontFamily: "CairoSemiBold",
                                              fontSize: 14.sp,
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.2),
                                            ),
                                            filled: true,
                                            fillColor: Colors
                                                .white, //rgb(242, 242, 242)
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35.h,
                                        width: 85.w,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: glycemiePreMealT2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "CairoSemiBold",
                                            fontSize: 14.sp,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '1.80',
                                            hintStyle: TextStyle(
                                              fontFamily: "CairoSemiBold",
                                              fontSize: 14.sp,
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.2),
                                            ),
                                            filled: true,
                                            fillColor: Colors
                                                .white, //rgb(242, 242, 242)
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35.h,
                                        width: 85.w,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: glycemiePreMealT3,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontFamily: "CairoSemiBold",
                                            fontSize: 14.sp,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '2.50',
                                            hintStyle: TextStyle(
                                              fontFamily: "CairoSemiBold",
                                              fontSize: 14.sp,
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.2),
                                            ),
                                            filled: true,
                                            fillColor: Colors
                                                .white, //rgb(242, 242, 242)
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 27.h,
                                    width: 72.w,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(235, 35, 46, 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        bottomLeft: Radius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      'Hypo',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 27.h,
                                    width: 72.w,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(111, 193, 34, 1),
                                    ),
                                    child: Text(
                                      'Ok',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 27.h,
                                    width: 72.w,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(251, 187, 43, 1),
                                    ),
                                    child: Text(
                                      'Éleve',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 27.h,
                                    width: 72.w,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(248, 99, 0, 1),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      'Hyper',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Card(
                        shadowColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              10.verticalSpace,
                              Container(
                                height: 45.h,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset("assets/images/image_2.png"),
                              ),
                              10.verticalSpace,
                              Container(
                                height: 20.h,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: Text(
                                  'Glycémies après repas',
                                  style: TextStyle(
                                    fontFamily: "CairoSemiBold",
                                    fontSize: 14.h,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              ),
                              15.verticalSpace,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  height: 35.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 35.h,
                                        width: 85.w,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: glycemiePostMealT1,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: "CairoSemiBold",
                                            fontSize: 14.sp,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '0.69',
                                            hintStyle: TextStyle(
                                              fontFamily: "CairoSemiBold",
                                              fontSize: 14.sp,
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.2),
                                            ),
                                            filled: true,
                                            fillColor: Colors
                                                .white, //rgb(242, 242, 242)
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35.h,
                                        width: 85.w,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: glycemiePostMealT2,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "CairoSemiBold",
                                            fontSize: 14.sp,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '1.80',
                                            hintStyle: TextStyle(
                                              fontFamily: "CairoSemiBold",
                                              fontSize: 14.sp,
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.2),
                                            ),
                                            filled: true,
                                            fillColor: Colors
                                                .white, //rgb(242, 242, 242)
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35.h,
                                        width: 85.w,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: glycemiePostMealT3,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontFamily: "CairoSemiBold",
                                            fontSize: 14.sp,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '2.50',
                                            hintStyle: TextStyle(
                                              fontFamily: "CairoSemiBold",
                                              fontSize: 14.sp,
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.2),
                                            ),
                                            filled: true,
                                            fillColor: Colors
                                                .white, //rgb(242, 242, 242)
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 27.h,
                                    width: 72.w,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(235, 35, 46, 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        bottomLeft: Radius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      'Hypo',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 27.h,
                                    width: 72.w,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(111, 193, 34, 1),
                                    ),
                                    child: Text(
                                      'Ok',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 27.h,
                                    width: 72.w,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(251, 187, 43, 1),
                                    ),
                                    child: Text(
                                      'Éleve',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 27.h,
                                    width: 72.w,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(248, 99, 0, 1),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      'Hyper',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Card(
                        shadowColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              10.verticalSpace,
                              Container(
                                height: 45.h,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset("assets/images/image_3.png"),
                              ),
                              10.verticalSpace,
                              Container(
                                height: 20.h,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: Text(
                                  'HBA1C (entre 6 et 7)',
                                  style: TextStyle(
                                    fontFamily: "CairoSemiBold",
                                    fontSize: 14.h,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              ),
                              15.verticalSpace,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  height: 35.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 35.h,
                                        width: 90.w,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          controller: hba1c,
                                          style: TextStyle(
                                            fontFamily: "CairoSemiBold",
                                            fontSize: 14.sp,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '6',
                                            hintStyle: TextStyle(
                                              fontFamily: "CairoSemiBold",
                                              fontSize: 14.sp,
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.2),
                                            ),
                                            filled: true,
                                            fillColor: Colors
                                                .white, //rgb(242, 242, 242)
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 27.h,
                                    width: 144.w,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(111, 193, 34, 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        bottomLeft: Radius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      'Ok',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 27.h,
                                    width: 144.w,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(251, 187, 43, 1),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      'Surveiller',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Card(
                        shadowColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              10.verticalSpace,
                              Container(
                                height: 45.h,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset("assets/images/image_4.png"),
                              ),
                              10.verticalSpace,
                              Container(
                                height: 20.h,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: Text(
                                  'Nombre de pas par jour',
                                  style: TextStyle(
                                    fontFamily: "CairoSemiBold",
                                    fontSize: 14.h,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              ),
                              15.verticalSpace,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  height: 35.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 35.h,
                                        width: 150.w,
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: stepsPerDay,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "CairoSemiBold",
                                            fontSize: 14.sp,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '10000',
                                            hintStyle: TextStyle(
                                              fontFamily: "CairoSemiBold",
                                              fontSize: 14.sp,
                                              color: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.2),
                                            ),
                                            filled: true,
                                            fillColor: Colors
                                                .white, //rgb(242, 242, 242)
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 27.h,
                                    width: 144.w,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(111, 193, 34, 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        bottomLeft: Radius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      'Ok',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 27.h,
                                    width: 144.w,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(251, 187, 43, 1),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      'Surveiller',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    30.verticalSpace,
                    InkWell(
                      onTap: () async {
                        User user = User.fromJson(
                            await SessionManager().get("currentUser"));
                        if (!Tools().isValidate(
                            glycemiePostMealT1.text,
                            glycemiePostMealT2.text,
                            glycemiePostMealT3.text,
                            glycemiePreMealT1.text,
                            glycemiePreMealT2.text,
                            glycemiePreMealT3.text,
                            hba1c.text,
                            stepsPerDay.text)) {
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur",
                              "Vous avez oublié de saisir une valeur, vous pouvez utiliser les valeurs par défaut ou remplir le formulaire");
                        } else {
                          setState(() {
                            _loading = true;
                          });
                          user.glycPostMealT1 = glycemiePostMealT1.text;
                          user.glycPostMealT2 = glycemiePostMealT2.text;
                          user.glycPostMealT3 = glycemiePostMealT3.text;
                          user.glycPreMealT1 = glycemiePreMealT1.text;
                          user.glycPreMealT2 = glycemiePreMealT2.text;
                          user.glycPreMealT3 = glycemiePreMealT3.text;
                          user.hba1c = hba1c.text;
                          user.stepsPerDay = stepsPerDay.text;
                          user.status = true;
                          await SessionManager().set('currentUser', user);
                          isSuccess = true;
                        }
                        if (isSuccess) {
                          await Api().completUser(user).then(
                            (value) async {
                              if (value == "RECORD_CREATED_SUCCESSFULLY") {
                                await Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    child: const MainScreen(
                                      index: 0,
                                    ),
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                  ),
                                );
                              } else {
                                setState(() {
                                  _loading = false;
                                });
                                Tools().showDesachievementView(
                                    context,
                                    "Message d'erreur",
                                    "Il y a une erreur, veuillez réessayer, si vous rencontrez toujours cette erreur, contactez le support.");
                              }
                            },
                          );
                        }
                      },
                      child: Center(
                        child: Container(
                          height: 55.h,
                          width: 220.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Terminer",
                            style: TextStyle(
                              fontFamily: 'CairoBold',
                              fontSize: 14.sp,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    5.verticalSpace,
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          _loading = true;
                        });
                        await Tools().useDefaultValue(context).then((value) {
                          setState(() {
                            _loading = value;
                          });
                        });
                      },
                      child: Text(
                        "Utiliser les valeurs par défault",
                        style: TextStyle(
                          fontFamily: "CairoSemiBold",
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

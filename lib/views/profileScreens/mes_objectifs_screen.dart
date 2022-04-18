// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/user.dart';
import 'package:loading_overlay/loading_overlay.dart';

// ignore: must_be_immutable
class MesObjectifsScreen extends StatefulWidget {
  const MesObjectifsScreen({Key? key}) : super(key: key);

  @override
  State<MesObjectifsScreen> createState() => _MesObjectifsScreenState();
}

class _MesObjectifsScreenState extends State<MesObjectifsScreen> {
  TextEditingController glycemiePreMealT1 = TextEditingController();
  TextEditingController glycemiePreMealT2 = TextEditingController();
  TextEditingController glycemiePreMealT3 = TextEditingController();

  TextEditingController glycemiePostMealT1 = TextEditingController();
  TextEditingController glycemiePostMealT2 = TextEditingController();
  TextEditingController glycemiePostMealT3 = TextEditingController();

  TextEditingController stepsPerDay = TextEditingController();
  TextEditingController hba1c = TextEditingController();
  bool _saving = false;

  // ignore: non_constant_identifier_names
  _SetState() async {
    await SessionManager().get('user').then((value) async {
      User user = User.fromJson(value);
      setState(() {
        glycemiePostMealT1.text = user.glycPostMealT1;
        glycemiePostMealT2.text = user.glycPostMealT2;
        glycemiePostMealT3.text = user.glycPostMealT3;
        glycemiePreMealT1.text = user.glycPreMealT1;
        glycemiePreMealT2.text = user.glycPreMealT2;
        glycemiePreMealT3.text = user.glycPreMealT3;
        stepsPerDay.text = user.stepsPerDay;
        hba1c.text = user.hba1c;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _SetState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        isLoading: _saving,
        color: Theme.of(context).primaryColorDark,
        progressIndicator: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 6.0,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
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
                  Boxicons.bxs_user,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                20.verticalSpace,
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                        fillColor:
                                            Colors.white, //rgb(242, 242, 242)
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
                                        fillColor:
                                            Colors.white, //rgb(242, 242, 242)
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
                                        fillColor:
                                            Colors.white, //rgb(242, 242, 242)
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
                20.verticalSpace,
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                        fillColor:
                                            Colors.white, //rgb(242, 242, 242)
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
                                        fillColor:
                                            Colors.white, //rgb(242, 242, 242)
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
                                        fillColor:
                                            Colors.white, //rgb(242, 242, 242)
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
                20.verticalSpace,
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                        fillColor:
                                            Colors.white, //rgb(242, 242, 242)
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
                20.verticalSpace,
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                        fillColor:
                                            Colors.white, //rgb(242, 242, 242)
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
                Center(
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        _saving = true;
                      });
                      User user =
                          User.fromJson(await SessionManager().get("user"));
                      user.glycPostMealT1 = glycemiePostMealT1.text;
                      user.glycPostMealT2 = glycemiePostMealT2.text;
                      user.glycPostMealT3 = glycemiePostMealT3.text;
                      user.glycPreMealT1 = glycemiePreMealT1.text;
                      user.glycPreMealT2 = glycemiePreMealT2.text;
                      user.glycPreMealT3 = glycemiePreMealT3.text;
                      user.hba1c = hba1c.text;
                      user.stepsPerDay = stepsPerDay.text;
                      await SessionManager().set('user', user);
                      await Api().updateUser(user).then((value) async {
                        if (value == "RECORD_CREATED_SUCCESSFULLY") {
                          Navigator.pop(context);
                          Tools().showAchievementView(
                              context,
                              'Modification réussie.',
                              'Vos objectifs ont été modifiés.');
                        } else {
                          setState(() {
                            _saving = false;
                          });
                        }
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
                        "Términer",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

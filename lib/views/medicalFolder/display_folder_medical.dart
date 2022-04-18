// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/Functions/Tools.dart';
import 'package:glucotel/model/MedicalFolder.dart';
import 'package:glucotel/views/mainScreens/main_screen.dart';
import 'package:glucotel/views/medicalFolder/edit_medical_folder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class DisplayFolderMedicalScreen extends StatefulWidget {
  const DisplayFolderMedicalScreen({Key? key}) : super(key: key);

  @override
  State<DisplayFolderMedicalScreen> createState() =>
      _DisplayFolderMedicalScreenState();
}

class _DisplayFolderMedicalScreenState
    extends State<DisplayFolderMedicalScreen> {
  Future<MedicalFolder> getFolderMedical() async {
    MedicalFolder folderMedical =
        MedicalFolder.fromJson(await SessionManager().get("medicalFolder"));
    return folderMedical;
  }

  MedicalFolder folder = MedicalFolder();

  //bool _isLoading = true;

  @override
  void initState() {
    getFolderMedical().then((value) {
      setState(() {
        folder = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Tools().showAlertDialogExit(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                pushNewScreen(
                  context,
                  screen: const MainScreen(
                    index: 0,
                  ),
                  pageTransitionAnimation: PageTransitionAnimation.slideRight,
                );
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
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const EditMedicalFolderScreen(),
                      type: PageTransitionType.leftToRight,
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20.0.w),
                  child: Center(
                    child: Text(
                      'Modifier',
                      style: TextStyle(
                        fontFamily: 'CairoSemiBold',
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              )
            ],
            elevation: 0,
            // like this!
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text(
                  'Mon Dossier Médical',
                  style: TextStyle(
                    fontFamily: 'CairoBold',
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Générale',
                  style: TextStyle(
                    fontFamily: 'CairoBold',
                    fontSize: 16.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Type de diabète',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.typeDiabete,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Mutuelle',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.mutuele,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Insuline',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.insuline,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Insuline Depuis',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.insulineDepuis,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Régime',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.regime,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Mode découverte',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.decouverte,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Antécedents',
                  style: TextStyle(
                    fontFamily: 'CairoBold',
                    fontSize: 16.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'HTA',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.hta,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'HTA dépuis',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.htaDepuis,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Cholestérol',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.cholesterol,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Cholestérol Depuis',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.cholesterolDepuis,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Vitiligo',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.vitiligo,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Maladie thyroïdienne',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: 60.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.thyroidienne,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Maladie coeliaque',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: 80.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.coeliaque,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Maladie d\'addison',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.addison,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Alcool',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: 60.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.alcool,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Tabagisme',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: 80.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.tabagisme,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Tabagisme dépuis',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.tabagismeDepuis,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Complication',
                  style: TextStyle(
                    fontFamily: 'CairoBold',
                    fontSize: 16.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Maladie rénale',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 100.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.renale,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Maladie rénale dépuis',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 100.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.depuis,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Problème visuel (l\'oeil)',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 100.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.insuline,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Perte de sensibilité',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.sensibilite,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Plaie',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.plaie,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Mycose',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.mycose,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Text(
                              'Durillion',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            // ignore: sized_box_for_whitespace
                            Container(
                              width: 190.w,
                              alignment: Alignment.centerRight,
                              child: Text(
                                folder.durillion,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'CairoBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

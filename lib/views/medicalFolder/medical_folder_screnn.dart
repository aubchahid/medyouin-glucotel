// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/views/medicalFolder/new_medical_folder.dart';
import 'package:page_transition/page_transition.dart';

class MedicalFolderScreen extends StatefulWidget {
  const MedicalFolderScreen({Key? key}) : super(key: key);

  @override
  State<MedicalFolderScreen> createState() => _MedicalFolderScreenState();
}

class _MedicalFolderScreenState extends State<MedicalFolderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Boxicons.bxs_chevron_left,
              size: 36.h,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InkWell(
          onTap: () async {
            Navigator.push(
              context,
              PageTransition(
                  child: const NewMedicalFolderScreen(),
                  type: PageTransitionType.rightToLeft),
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
              "D??marrer le questionnaire",
              style: TextStyle(
                fontFamily: 'CairoBold',
                fontSize: 14.sp,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
              child: Text(
                'Nous vous conseillons de nous renseigner votre dossier m??dical digital (DMD)',
                style: TextStyle(
                  fontFamily: 'CairoSemiBold',
                  fontSize: 14.sp,
                  height: 1.3,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                'Quels sont les avantages du dossier m??dical digital (DMD)?',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'CairoSemiBold',
                  fontSize: 18.sp,
                  height: 1.3,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                'Cette action favorise la coordination la qualit?? et la continuit?? des soins, et assure un meilleur suivi de votre sant??. Cela permettra d\'??viter des examens ou des prescriptions inutiles, ainsi que des interactions entre les m??dicaments prescrits.',
                style: TextStyle(
                  fontFamily: 'CairoSemiBold',
                  fontSize: 14.sp,
                  height: 1.3,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                'Qui a acc??s au DMD',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'CairoSemiBold',
                  fontSize: 18.sp,
                  height: 1.3,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                'Vous-m??me et votre m??decin traitant.',
                style: TextStyle(
                  fontFamily: 'CairoSemiBold',
                  fontSize: 14.sp,
                  height: 1.3,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                'Qui conteint le DMD',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'CairoSemiBold',
                  fontSize: 18.sp,
                  height: 1.3,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                'Le dossier m??dical digital retrace votre ant??c??dent m??dical ainsi que votre ??tat de sant?? actual. En effet, il reprend les examens, les interventions chirurgicales et mentionne les traitements en cours.',
                style: TextStyle(
                  fontFamily: 'CairoSemiBold',
                  fontSize: 14.sp,
                  height: 1.3,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

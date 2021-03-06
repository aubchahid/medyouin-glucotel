// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/Functions/Tools.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/model/MedicalFolder.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/medicalFolder/display_folder_medical.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class EditMedicalFolderThreeScreen extends StatefulWidget {
  const EditMedicalFolderThreeScreen({Key? key}) : super(key: key);

  @override
  State<EditMedicalFolderThreeScreen> createState() =>
      _EditMedicalFolderThreeScreenState();
}

class _EditMedicalFolderThreeScreenState
    extends State<EditMedicalFolderThreeScreen> {
  bool _renale = false;
  bool _sensibilite = false;
  bool _plaie = false;
  bool _mycose = false;
  bool _durillion = false;
  bool _visuel = false;

  String _renaleString = "Oui";
  String _sensibiliteString = "Oui";
  String _visuelString = "Oui";
  String _plaieString = "Oui";
  String _mycoseString = "Oui";
  String _durillionString = "Oui";

  final TextEditingController _renaleDepuis = TextEditingController();

  bool _loading = false;

  getValues() async {
    Tools().getCurrentUser().then((value) async {
      MedicalFolder medicalFolder =
          MedicalFolder.fromJson(await SessionManager().get("medicalFolder"));

      setState(() {
        _loading = false;
        medicalFolder.renale == 'Oui' ? _renale = false : _renale = true;
        _renale ? _renaleString = 'Non' : _renaleString = 'Oui';
        _renale
            ? _renaleDepuis.text = '-'
            : _renaleDepuis.text = medicalFolder.depuis;

        medicalFolder.visual == 'Oui' ? _visuel = false : _visuel = true;
        _visuel ? _visuelString = 'Non' : _visuelString = 'Oui';

        medicalFolder.sensibilite == 'Oui'
            ? _sensibilite = false
            : _sensibilite = true;
        _sensibilite ? _sensibiliteString = 'Non' : _sensibiliteString = 'Oui';

        medicalFolder.plaie == 'Oui' ? _plaie = false : _plaie = true;
        _plaie ? _plaieString = 'Non' : _plaieString = 'Oui';

        medicalFolder.mycose == 'Oui' ? _mycose = false : _mycose = true;
        _mycose ? _mycoseString = 'Non' : _mycoseString = 'Oui';

        medicalFolder.durillion == 'Oui'
            ? _durillion = false
            : _durillion = true;
        _durillion ? _durillionString = 'Non' : _durillionString = 'Oui';
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getValues();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _loading,
      color: Theme.of(context).primaryColorDark,
      progressIndicator: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
        strokeWidth: 6.0,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
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
          body: Column(
            children: [
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                child: SizedBox(
                  height: 70.h,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: Column(
                          children: [
                            Container(
                              height: 35.h,
                              width: 35.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(350),
                              ),
                              child: Text(
                                '1',
                                style: TextStyle(
                                  fontFamily: "CairoBold",
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            5.verticalSpace,
                            Text(
                              'G??n??rale',
                              style: TextStyle(
                                fontFamily: "CairoBold",
                                fontSize: 14.sp,
                                height: 1.4,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 100.w,
                        child: Column(
                          children: [
                            Container(
                              height: 35.h,
                              width: 35.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(350),
                              ),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontFamily: "CairoBold",
                                  fontSize: 14.sp,
                                  height: 1.4,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            5.verticalSpace,
                            Text(
                              'Ant??c??dents',
                              style: TextStyle(
                                fontFamily: "CairoBold",
                                fontSize: 14.sp,
                                height: 1.4,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 100.w,
                        child: Column(
                          children: [
                            Container(
                              height: 35.h,
                              width: 35.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(350),
                              ),
                              child: Text(
                                '3',
                                style: TextStyle(
                                  fontFamily: "CairoBold",
                                  fontSize: 14.sp,
                                  height: 1.4,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            5.verticalSpace,
                            Text(
                              'Complication',
                              style: TextStyle(
                                fontFamily: "CairoBold",
                                fontSize: 14.sp,
                                height: 1.4,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                      child: SizedBox(
                        height: 95.h,
                        child: Column(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: 30.h,
                              child: Text(
                                'Maladie r??nale',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'CairoSemiBold',
                                  color: const Color.fromRGBO(30, 30, 30, 1),
                                ),
                              ),
                            ),
                            5.verticalSpace,
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _renale = false;
                                      _renaleString = "Oui";
                                      _renaleDepuis.text = '';
                                    });
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _renale
                                          ? Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2)
                                          : Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Oui',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                        color: _renale
                                            ? Theme.of(context).primaryColor
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _renale = true;
                                      _renaleString = "Non";
                                      _renaleDepuis.text = '-';
                                    });
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _renale
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Non',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                        color: _renale
                                            ? Colors.white
                                            : Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    _renale
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              10.verticalSpace,
                              Center(
                                child: Text(
                                  'Maladie r??nale depuis',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'CairoSemiBold',
                                    color: const Color.fromRGBO(30, 30, 30, 1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: SizedBox(
                                  height: 65.h,
                                  width: 160.w,
                                  child: TextField(
                                    textAlignVertical: TextAlignVertical.center,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    controller: _renaleDepuis,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      fontFamily: "CairoSemiBold",
                                      fontSize: 14.sp,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Depuis 2020',
                                      hintStyle: TextStyle(
                                        fontFamily: "CairoSemiBold",
                                        fontSize: 14.sp,
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromRGBO(
                                          231, 230, 235, 1),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2),
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
                            ],
                          ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                      child: SizedBox(
                        height: 95.h,
                        child: Column(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: 30.h,
                              child: Text(
                                'Probl??me visuel (l\'oeil)',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'CairoSemiBold',
                                  color: const Color.fromRGBO(30, 30, 30, 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _visuel = false;
                                      _visuelString = "Oui";
                                    });
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _visuel
                                          ? Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2)
                                          : Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Oui',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                        color: _visuel
                                            ? Theme.of(context).primaryColor
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _visuel = true;
                                      _visuelString = "Non";
                                    });
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _visuel
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Non',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                        color: _visuel
                                            ? Colors.white
                                            : Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                      child: SizedBox(
                        height: 95.h,
                        child: Column(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: 30.h,
                              child: Text(
                                'Perte de sensibilit??',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'CairoSemiBold',
                                  color: const Color.fromRGBO(30, 30, 30, 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _sensibilite = false;
                                      _sensibiliteString = "Oui";
                                    });
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _sensibilite
                                          ? Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2)
                                          : Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Oui',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                        color: _sensibilite
                                            ? Theme.of(context).primaryColor
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _sensibilite = true;
                                      _sensibiliteString = "Non";
                                    });
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _sensibilite
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Non',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                        color: _sensibilite
                                            ? Colors.white
                                            : Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                      child: SizedBox(
                        height: 95.h,
                        child: Column(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: 30.h,
                              child: Text(
                                'Plaie',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'CairoSemiBold',
                                  color: const Color.fromRGBO(30, 30, 30, 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _plaie = false;
                                      _plaieString = "Oui";
                                    });
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _plaie
                                          ? Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2)
                                          : Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Oui',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                        color: _plaie
                                            ? Theme.of(context).primaryColor
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _plaie = true;
                                      _plaieString = "Non";
                                    });
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _plaie
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Non',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                        color: _plaie
                                            ? Colors.white
                                            : Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                      child: SizedBox(
                        height: 95.h,
                        child: Column(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: 30.h,
                              child: Text(
                                'Mycose',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'CairoSemiBold',
                                  color: const Color.fromRGBO(30, 30, 30, 1),
                                ),
                              ),
                            ),
                            5.verticalSpace,
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _mycose = false;
                                      _mycoseString = "Oui";
                                    });
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _mycose
                                          ? Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2)
                                          : Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Oui',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                        color: _mycose
                                            ? Theme.of(context).primaryColor
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _mycose = true;
                                      _mycoseString = "Non";
                                    });
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _mycose
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Non',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                        color: _mycose
                                            ? Colors.white
                                            : Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                      child: SizedBox(
                        height: 95.h,
                        child: Column(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: 30.h,
                              child: Text(
                                'Durillion',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'CairoSemiBold',
                                  color: const Color.fromRGBO(30, 30, 30, 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _durillion = false;
                                      _durillionString = "Oui";
                                    });
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _durillion
                                          ? Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2)
                                          : Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Oui',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                        color: _durillion
                                            ? Theme.of(context).primaryColor
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _durillion = true;
                                      _durillionString = "Non";
                                    });
                                  },
                                  child: Container(
                                    height: 45.h,
                                    width: 150.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _durillion
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Non',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'CairoSemiBold',
                                        color: _durillion
                                            ? Colors.white
                                            : Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    Center(
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            _loading = true;
                          });
                          MedicalFolder medicalFolder = MedicalFolder.fromJson(
                            await SessionManager().get("medicalFolder"),
                          );
                          bool isValid = true;
                          String message = 'S\'il vous plait entrer : ';
                          _renale
                              ? isValid == (_renaleDepuis.text == '-')
                              : isValid = _renaleDepuis.text.isNotEmpty;
                          _renaleDepuis.text.isEmpty
                              ? message = message + 'Maladie r??nale Depuis, '
                              : message = message;
                          if (isValid) {
                            medicalFolder.renale = _renaleString;
                            medicalFolder.depuis = _renaleDepuis.text;

                            medicalFolder.visual = _visuelString;
                            medicalFolder.sensibilite = _sensibiliteString;
                            medicalFolder.plaie = _plaieString;
                            medicalFolder.mycose = _mycoseString;
                            medicalFolder.durillion = _durillionString;
                            medicalFolder.status = true;
                            await SessionManager()
                                .set("medicalFolder", medicalFolder)
                                .then((value) async {
                              User user = User.fromJson(
                                  await SessionManager().get("currentUser"));
                              await Api()
                                  .updatefolderMedical(medicalFolder, user)
                                  .then((value) {
                                if (value == 'RECORD_CREATED_SUCCESSFULLY') {
                                  Tools().showAchievementView(
                                      context,
                                      "Modification r??ussie.",
                                      "Votre dossier m??dical a ??t?? modifi?? avec succ??s.");
                                  pushNewScreen(
                                    context,
                                    screen: const DisplayFolderMedicalScreen(),
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                } else {
                                  setState(() {
                                    _loading = false;
                                  });
                                }
                              });
                            });
                          } else {
                            Tools().showDesachievementView(
                                context, "Message d'erreur", message);
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
                    40.verticalSpace,
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

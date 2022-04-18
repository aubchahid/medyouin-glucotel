// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/Functions/Tools.dart';
import 'package:glucotel/model/MedicalFolder.dart';
import 'package:glucotel/views/medicalFolder/edit_medical_folder_three.dart';
import 'package:page_transition/page_transition.dart';

class EditMedicalFolderScreenTwo extends StatefulWidget {
  const EditMedicalFolderScreenTwo({Key? key}) : super(key: key);

  @override
  State<EditMedicalFolderScreenTwo> createState() =>
      _EditMedicalFolderScreenTwoState();
}

class _EditMedicalFolderScreenTwoState
    extends State<EditMedicalFolderScreenTwo> {
  bool _hta = false;
  bool _cholesterol = false;
  bool _tabac = false;
  bool _vitiligo = false;
  bool _thyroidienne = false;
  bool _coeliaque = false;
  bool _addison = false;
  bool _alcool = false;
  bool _isLoading = false;

  String _htaString = "Oui";
  String _cholesterolString = "Oui";

  String _alcoolString = "Oui";
  String _tabacString = "Oui";
  String _vitiligoString = "Oui";
  String _thyroidienneString = "Oui";
  String _coeliaqueString = "Oui";
  String _addisonString = "Oui";

  final TextEditingController _htaDepuis = TextEditingController();
  final TextEditingController _cholesterolDepuis = TextEditingController();
  final TextEditingController _tabacDepuis = TextEditingController();

  getValues() async {
    Tools().getCurrentUser().then((value) async {
      MedicalFolder medicalFolder =
          MedicalFolder.fromJson(await SessionManager().get("medicalFolder"));
      print(medicalFolder.toJson());
      setState(() {
        _isLoading = true;
        medicalFolder.hta == 'Oui' ? _hta = false : _hta = true;
        !_hta ? _htaString = 'Oui' : _htaString = 'Non';
        !_hta
            ? _htaDepuis.text = medicalFolder.htaDepuis
            : _htaDepuis.text = '';

        medicalFolder.cholesterol == 'Oui'
            ? _cholesterol = false
            : _cholesterol = true;
        !_cholesterol ? _cholesterolString = 'Oui' : _cholesterolString = 'Non';
        !_cholesterol
            ? _cholesterolDepuis.text = medicalFolder.cholesterolDepuis
            : _cholesterolDepuis.text = '';

        medicalFolder.alcool == 'Oui' ? _alcool = false : _alcool = true;
        !_alcool ? _alcoolString = 'Oui' : _alcoolString = 'Non';

        medicalFolder.tabagisme == 'Oui' ? _tabac = false : _tabac = true;
        !_tabac ? _tabacString = 'Oui' : _tabacString = 'Non';
        !_tabac
            ? _tabacDepuis.text = medicalFolder.cholesterolDepuis
            : _tabacDepuis.text = '';

        medicalFolder.vitiligo == 'Oui' ? _vitiligo = false : _vitiligo = true;
        !_vitiligo ? _vitiligoString = 'Oui' : _vitiligoString = 'Non';

        medicalFolder.thyroidienne == 'Oui'
            ? _thyroidienne = false
            : _thyroidienne = true;
        !_thyroidienne
            ? _thyroidienneString = 'Oui'
            : _thyroidienneString = 'Non';

        medicalFolder.addison == 'Oui' ? _addison = false : _addison = true;
        !_addison ? _addisonString = 'Oui' : _addisonString = 'Non';

        medicalFolder.coeliaque == 'Oui'
            ? _coeliaque = false
            : _coeliaque = true;
        !_coeliaque ? _coeliaqueString = 'Oui' : _coeliaqueString = 'Non';
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
    return SafeArea(
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
                            'Générale',
                            style: TextStyle(
                              fontFamily: "CairoBold",
                              fontSize: 14.sp,
                              color: Theme.of(context).primaryColor,
                              height: 1.4,
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
                                color: Colors.white,
                                height: 1.4,
                              ),
                            ),
                          ),
                          5.verticalSpace,
                          Text(
                            'Antécédents',
                            style: TextStyle(
                              fontFamily: "CairoBold",
                              fontSize: 14.sp,
                              color: Theme.of(context).primaryColor,
                              height: 1.4,
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
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(350),
                            ),
                            child: Text(
                              '3',
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
                            'Complication',
                            style: TextStyle(
                              fontFamily: "CairoBold",
                              fontSize: 14.sp,
                              color: Colors.grey,
                              height: 1.4,
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
                              'Hta',
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
                                    _hta = false;
                                    _htaString = 'Oui';
                                    _htaDepuis.text = '';
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _hta
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
                                      color: _hta
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
                                    _hta = true;
                                    _htaString = 'Non';
                                    _htaDepuis.text = '-';
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _hta
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
                                      color: _hta
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
                  _hta
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                              child: Text(
                                'HTA depuis',
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
                                  controller: _htaDepuis,
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
                                    fillColor:
                                        const Color.fromRGBO(235, 235, 235, 1),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
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
                              'Cholesterol',
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
                                    _cholesterol = false;
                                    _cholesterolString = 'Oui';
                                    _cholesterolDepuis.text = '';
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _cholesterol
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
                                      color: _cholesterol
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
                                    _cholesterol = true;
                                    _cholesterolString = "Non";
                                    _cholesterolDepuis.text = '-';
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _cholesterol
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
                                      color: _cholesterol
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
                  _cholesterol
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                              child: Text(
                                'Cholesterol depuis',
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
                                  controller: _cholesterolDepuis,
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
                                    fillColor:
                                        const Color.fromRGBO(235, 235, 235, 1),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
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
                              'Alcool',
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
                                    _alcool = false;
                                    _alcoolString = "Oui";
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _alcool
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
                                      color: _alcool
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
                                    _alcool = true;
                                    _alcoolString = "Non";
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _alcool
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
                                      color: _alcool
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
                              'Tabagisme',
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
                                    _tabac = false;
                                    _tabacString = 'Oui';
                                    _tabacDepuis.text = '';
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _tabac
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
                                      color: _tabac
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
                                    _tabac = true;
                                    _tabacString = 'Non';
                                    _tabacDepuis.text = '-';
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _tabac
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
                                      color: _tabac
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
                  _tabac
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            5.verticalSpace,
                            Center(
                              child: Text(
                                'Tabagisme depuis',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'CairoSemiBold',
                                  color: const Color.fromRGBO(30, 30, 30, 1),
                                ),
                              ),
                            ),
                            5.verticalSpace,
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
                                  controller: _tabacDepuis,
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
                                    fillColor:
                                        const Color.fromRGBO(235, 235, 235, 1),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
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
                              'Vitiligo',
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
                                    _vitiligo = false;
                                    _vitiligoString = "Oui";
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _vitiligo
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
                                      color: _vitiligo
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
                                    _vitiligo = true;
                                    _vitiligoString = "Non";
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _vitiligo
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
                                      color: _vitiligo
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
                  SizedBox(
                    height: 5.h,
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
                              'Maladie Thyroïdienne',
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
                                    _thyroidienne = false;
                                    _thyroidienneString = "Oui";
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _thyroidienne
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
                                      color: _thyroidienne
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
                                    _thyroidienne = true;
                                    _thyroidienneString = "Non";
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _thyroidienne
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
                                      color: _thyroidienne
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
                  SizedBox(
                    height: 5.h,
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
                              'Maladie d\'addison',
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
                                    _addison = false;
                                    _addisonString = "Oui";
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _addison
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
                                      color: _addison
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
                                    _addison = true;
                                    _addisonString = "Non";
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _addison
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
                                      color: _addison
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
                  SizedBox(
                    height: 5.h,
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
                              'Maladie coeliaque',
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
                                    _coeliaque = false;
                                    _coeliaqueString = "Oui";
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _coeliaque
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
                                      color: _coeliaque
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
                                    _coeliaque = true;
                                    _coeliaqueString = "Non";
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: 150.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _coeliaque
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
                                      color: _coeliaque
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
                        MedicalFolder medicalFolder = MedicalFolder.fromJson(
                          await SessionManager().get("medicalFolder"),
                        );
                        medicalFolder.hta = _htaString;
                        medicalFolder.htaDepuis = _htaDepuis.text;
                        medicalFolder.cholesterol = _cholesterolString;
                        medicalFolder.cholesterolDepuis =
                            _cholesterolDepuis.text;
                        medicalFolder.alcool = _alcoolString;
                        medicalFolder.tabagisme = _tabacString;
                        medicalFolder.tabagismeDepuis = _tabacDepuis.text;
                        medicalFolder.vitiligo = _vitiligoString;
                        medicalFolder.thyroidienne = _thyroidienneString;
                        medicalFolder.coeliaque = _coeliaqueString;
                        medicalFolder.addison = _addisonString;
                        bool isValid = true;
                        String message = 'S\'il vous plait entrer : ';
                        _hta
                            ? isValid == (_htaDepuis.text == '-')
                            : isValid = _htaDepuis.text.isNotEmpty;
                        _htaDepuis.text.isEmpty
                            ? message = message + 'Hta Depuis, '
                            : message = message;
                        _cholesterol
                            ? isValid == (_cholesterolDepuis.text == '-')
                            : isValid = _cholesterolDepuis.text.isNotEmpty;
                        _cholesterolDepuis.text.isEmpty
                            ? message = message + 'Cholesterol Depuis, '
                            : message = message;
                        _tabac
                            ? isValid == (_tabacDepuis.text == '-')
                            : isValid = _tabacDepuis.text.isNotEmpty;
                        _tabacDepuis.text.isEmpty
                            ? message = message + 'Tabagisme Depuis, '
                            : message = message;
                        if (isValid) {
                          await SessionManager()
                              .set("medicalFolder", medicalFolder)
                              .then((value) async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                child: const EditMedicalFolderThreeScreen(),
                                type: PageTransitionType.rightToLeftWithFade,
                              ),
                            );
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
                          "Suivant",
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
    );
  }
}

// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/Functions/Tools.dart';
import 'package:glucotel/model/ListItem.dart';
import 'package:glucotel/model/MedicalFolder.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/medicalFolder/edit_medical_folder_two.dart';
import 'package:page_transition/page_transition.dart';

class EditMedicalFolderScreen extends StatefulWidget {
  const EditMedicalFolderScreen({Key? key}) : super(key: key);

  @override
  State<EditMedicalFolderScreen> createState() =>
      _EditMedicalFolderScreenState();
}

class _EditMedicalFolderScreenState extends State<EditMedicalFolderScreen> {
  bool _type = false, _isLoading = false;
  bool _mutuelle = false;
  bool _regime = false;
  bool _insuline = false;
  String _typeDiabete = "Type 1";
  String _mutuelleString = "Oui";
  String _regimeString = "Oui";
  String _insulineString = "Oui";
  List<DropdownMenuItem<ListItem>>? _dropdownDecouvertItems;
  ListItem? _decouvert;
  final TextEditingController _insulineDepuis = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  User? currentUser;
  final List<ListItem> _decouvertItems = [
    ListItem("Bilan pour un autre maladie", "Bilan pour un autre maladie"),
    ListItem("Soif intense et urines abondantes",
        "Soif intense et urines abondantes"),
    ListItem("Fatigue chronique", "Fatigue chronique"),
    ListItem("Perte de poids  inexpliquée", "Perte de poids  inexpliquée"),
  ];

  List<DropdownMenuItem<ListItem>>? buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>>? items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  getValues() async {
    Tools().getCurrentUser().then((value) async {
      _dropdownDecouvertItems = buildDropDownMenuItems(_decouvertItems);
      MedicalFolder medicalFolder =
          MedicalFolder.fromJson(await SessionManager().get("medicalFolder"));
      setState(() {
        currentUser = value;
        currentUser!.typeDiabet == "Type 1" ? _type = false : _type = true;
        _type ? _typeDiabete = 'Type 2' : _typeDiabete = '1';
        _sizeController.text = currentUser!.size;
        _weightController.text = currentUser!.weight;
        medicalFolder.mutuele == 'Oui' ? _mutuelle = true : _mutuelle = false;
        if (medicalFolder.mutuele == 'Oui') {
          _mutuelle = false;
          _mutuelleString = 'Non';
        } else {
          _mutuelle = true;
          _mutuelleString = 'Oui';
        }
        if (medicalFolder.regime == 'Oui') {
          _regime = false;
          _regimeString = 'Non';
        } else {
          _regime = true;
          _regimeString = 'Oui';
        }

        if (medicalFolder.decouverte == "Bilan pour un autre maladie") {
          _decouvert = _dropdownDecouvertItems![0].value;
        }
        if (medicalFolder.decouverte == "Soif intense et urines abondantes") {
          _decouvert = _dropdownDecouvertItems![1].value;
        }
        if (medicalFolder.decouverte == "Fatigue chronique") {
          _decouvert = _dropdownDecouvertItems![2].value;
        }
        if (medicalFolder.decouverte == "Perte de poids  inexpliquée") {
          _decouvert = _dropdownDecouvertItems![3].value;
        }
        medicalFolder.insuline == 'Non' ? _insuline = true : _insuline = false;
        _insuline
            ? _insulineDepuis.text = medicalFolder.insulineDepuis
            : _insulineDepuis.text = '';
        _isLoading = true;
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
        body: !_isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  10.verticalSpace,
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
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
                                    color: Colors.grey,
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
                                    color: Colors.grey,
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
                        5.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 65.h,
                                width: 160.w,
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  controller: _sizeController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontFamily: "CairoSemiBold",
                                    fontSize: 14.sp,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Taille (cm)',
                                    hintStyle: TextStyle(
                                      fontFamily: "NunitoRegular",
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
                              const Spacer(),
                              SizedBox(
                                height: 65.h,
                                width: 160.w,
                                child: TextField(
                                  controller: _weightController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontFamily: "CairoSemiBold",
                                    fontSize: 14.sp,
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: Container(
                                      width: 15,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Kg',
                                        style: TextStyle(
                                          fontFamily: "CairoSemiBold",
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                    hintText: 'Poids (kg)',
                                    hintStyle: TextStyle(
                                      fontFamily: "NunitoRegular",
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
                            ],
                          ),
                        ),
                        5.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 20.w),
                          child: SizedBox(
                            height: 95.h,
                            child: Column(
                              children: [
                                const Spacer(),
                                SizedBox(
                                  height: 30.h,
                                  child: Text(
                                    'Type de diabète',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'CairoSemiBold',
                                      color:
                                          const Color.fromRGBO(30, 30, 30, 1),
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
                                          _type = false;
                                          _typeDiabete = "Type 1";
                                          _insulineDepuis.text = '-';
                                          _insulineString = 'Non';
                                        });
                                      },
                                      child: Container(
                                        height: 45.h,
                                        width: 150.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: _type
                                              ? Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.2)
                                              : Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'Type 1',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'CairoSemiBold',
                                            color: _type
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
                                          _type = true;
                                          _typeDiabete = "Type 2";
                                          _insulineDepuis.text = '';
                                        });
                                      },
                                      child: Container(
                                        height: 45.h,
                                        width: 150.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: _type
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'Type 2',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'CairoSemiBold',
                                            color: _type
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .primaryColor,
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
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 20.w),
                          child: SizedBox(
                            height: 95.h,
                            child: Column(
                              children: [
                                const Spacer(),
                                SizedBox(
                                  height: 30.h,
                                  child: Text(
                                    'Mutuelle',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'CairoSemiBold',
                                      color:
                                          const Color.fromRGBO(30, 30, 30, 1),
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
                                          _mutuelle = false;
                                          _mutuelleString = 'Oui';
                                        });
                                      },
                                      child: Container(
                                        height: 45.h,
                                        width: 150.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: _mutuelle
                                              ? Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.2)
                                              : Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'Oui',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'CairoSemiBold',
                                            color: _mutuelle
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
                                          _mutuelle = true;
                                          _mutuelleString = 'Non';
                                        });
                                      },
                                      child: Container(
                                        height: 45.h,
                                        width: 150.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: _mutuelle
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'Non',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'CairoSemiBold',
                                            color: _mutuelle
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .primaryColor,
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
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 20.w),
                          child: SizedBox(
                            height: 95.h,
                            child: Column(
                              children: [
                                const Spacer(),
                                SizedBox(
                                  height: 30.h,
                                  child: Text(
                                    'Sous régime actuel pour votre diabète',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'CairoSemiBold',
                                      color:
                                          const Color.fromRGBO(30, 30, 30, 1),
                                    ),
                                  ),
                                ),
                                5.verticalSpace,
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _regime = false;
                                          _regimeString = 'Oui';
                                        });
                                      },
                                      child: Container(
                                        height: 45.h,
                                        width: 150.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: _regime
                                              ? Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.2)
                                              : Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'Oui',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'CairoSemiBold',
                                            color: _regime
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
                                          _regime = true;
                                          _regimeString = 'Non';
                                        });
                                      },
                                      child: Container(
                                        height: 45.h,
                                        width: 150.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: _regime
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'Non',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'CairoSemiBold',
                                            color: _regime
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .primaryColor,
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
                          height: 95.h,
                          child: Column(
                            children: [
                              const Spacer(),
                              SizedBox(
                                height: 25.h,
                                child: Text(
                                  'Mode Découverte',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'CairoSemiBold',
                                    color: const Color.fromRGBO(30, 30, 30, 1),
                                  ),
                                ),
                              ),
                              5.verticalSpace,
                              Container(
                                height: 65.h,
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(231, 230, 235, 1),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromRGBO(30, 30, 30, 1)
                                          .withAlpha(20),
                                      spreadRadius: 5,
                                      blurRadius: 40,
                                      offset: const Offset(
                                          0, 16), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<ListItem>(
                                      value: _decouvert,
                                      items: _dropdownDecouvertItems,
                                      style: TextStyle(
                                        fontFamily: "CairoSemiBold",
                                        fontSize: 14.sp,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      iconSize: 20,
                                      icon: const Icon(
                                        Boxicons.bxs_chevron_down,
                                      ),
                                      iconEnabledColor: Colors.grey[800],
                                      isExpanded: true,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            _decouvert = value;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _type
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 20.w),
                                    child: SizedBox(
                                      height: 95.h,
                                      width: 300.w,
                                      child: Column(
                                        children: [
                                          const Spacer(),
                                          SizedBox(
                                            height: 30.h,
                                            child: Text(
                                              'Insuline',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontFamily: 'CairoSemiBold',
                                                color: const Color.fromRGBO(
                                                    30, 30, 30, 1),
                                              ),
                                            ),
                                          ),
                                          5.verticalSpace,
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _insuline = false;
                                                    _insulineString = 'Oui';
                                                    _insulineDepuis.text = '';
                                                  });
                                                },
                                                child: Container(
                                                  height: 45.h,
                                                  width: 150.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: _insuline
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                            .withOpacity(0.2)
                                                        : Theme.of(context)
                                                            .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Text(
                                                    'Oui',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontFamily:
                                                          'CairoSemiBold',
                                                      color: _insuline
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _insuline = true;
                                                    _insulineString = 'Non';
                                                    _insulineDepuis.text = '-';
                                                  });
                                                },
                                                child: Container(
                                                  height: 45.h,
                                                  width: 150.w,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: _insuline
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Theme.of(context)
                                                            .primaryColor
                                                            .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Text(
                                                    'Non',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontFamily:
                                                          'CairoSemiBold',
                                                      color: _insuline
                                                          ? Colors.white
                                                          : Theme.of(context)
                                                              .primaryColor,
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
                                  _insuline
                                      ? Container()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Center(
                                              child: Text(
                                                'Insuline depuis',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontFamily: 'CairoSemiBold',
                                                  color: const Color.fromRGBO(
                                                      30, 30, 30, 1),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w),
                                              child: SizedBox(
                                                height: 65.h,
                                                width: 160.w,
                                                child: TextField(
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    LengthLimitingTextInputFormatter(
                                                        4),
                                                  ],
                                                  controller: _insulineDepuis,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                    fontFamily: "CairoSemiBold",
                                                    fontSize: 14.sp,
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintText: 'Depuis 2020',
                                                    hintStyle: TextStyle(
                                                      fontFamily:
                                                          "CairoSemiBold",
                                                      fontSize: 14.sp,
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        const Color.fromRGBO(
                                                            235, 235, 235, 1),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              )
                            : Container(),
                        20.verticalSpace,
                        Center(
                          child: InkWell(
                            onTap: () async {
                              bool isValid = true;
                              String message = 'S\'il vous plait entrer : ';
                              User user = User.fromJson(
                                  await SessionManager().get("currentUser"));
                              if (_type) {
                                _insuline
                                    ? isValid == (_insulineDepuis.text == '-')
                                    : isValid = _insulineDepuis.text.isNotEmpty;
                                _insulineDepuis.text.isEmpty
                                    ? message = message + 'Insuline Depuis, '
                                    : message = message;
                              }
                              if (isValid) {
                                user.size = _sizeController.text;
                                user.weight = _weightController.text;
                                user.typeDiabet = _typeDiabete;
                                await SessionManager().set('currentUser', user);
                                MedicalFolder medicalFolder =
                                    MedicalFolder.fromJson(
                                  await SessionManager().get("medicalFolder"),
                                );
                                medicalFolder.typeDiabete = _typeDiabete;
                                medicalFolder.mutuele = _mutuelleString;
                                medicalFolder.regime = _regimeString;
                                medicalFolder.decouverte = _decouvert!.value;
                                medicalFolder.insuline = _insulineString;
                                medicalFolder.insulineDepuis =
                                    _insulineDepuis.text;
                                await SessionManager()
                                    .set("medicalFolder", medicalFolder);
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    child: const EditMedicalFolderScreenTwo(),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
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
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        40.verticalSpace,
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/ListItem.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/complete_profil_second_screen.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  String _birthdateController = 'Date de naissance';
  DateTime selectedDate = DateTime.now();
  List<DropdownMenuItem<ListItem>>? _dropdownSexeItems;
  ListItem? _sexe;
  List<DropdownMenuItem<ListItem>>? _dropdownTypeDiabetItems;
  ListItem? _typeDiabet;
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  bool _isBirthdayEmpty = true,
      _isWeightEmpty = false,
      _isSizeEmpty = false,
      _isSexeEmpty = false,
      _isTypeEmpty = false,
      _isCityEmpty = false;
  final List<ListItem> _sexeItems = [
    ListItem("-", "Choisissez votre sexe"),
    ListItem("Homme", "Homme"),
    ListItem("Femme", "Femme"),
  ];

  final List<ListItem> _typeDiabetItems = [
    ListItem("-", "Votre type de diabète"),
    ListItem("Type 1", "Type 1"),
    ListItem("Type 2", "Type 2"),
  ];

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      locale: const Locale('fr', ''),
    );

    if (picked != null)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        selectedDate = picked;
        _birthdateController = DateFormat("dd-MM-yyyy").format(selectedDate);
        _isBirthdayEmpty = true;
      });
  }

  validateFields() {
    setState(() {
      _birthdateController == 'Date de naissance'
          ? _isBirthdayEmpty = false
          : _isBirthdayEmpty = true;
      _sexe!.value == '-' ? _isSexeEmpty = true : _isSexeEmpty = false;
      _typeDiabet!.value == '-' ? _isTypeEmpty = true : _isTypeEmpty = false;
      _isCityEmpty = _cityController.text.isEmpty;
      _isSizeEmpty = _sizeController.text.isEmpty;
      _isWeightEmpty = _weightController.text.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _dropdownSexeItems = Tools().buildDropDownMenuItems(_sexeItems);
    _sexe = _dropdownSexeItems![0].value;
    _dropdownTypeDiabetItems = Tools().buildDropDownMenuItems(_typeDiabetItems);
    _typeDiabet = _dropdownTypeDiabetItems![0].value;
    _isBirthdayEmpty = true;
    _isWeightEmpty = false;
    _isSizeEmpty = false;
    _isSexeEmpty = false;
    _isTypeEmpty = false;
    _isCityEmpty = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Tools().showAlertDialogExit(context),
      child: SafeArea(
        child: Scaffold(
          body: Column(
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
                        child: Center(
                          child: Image.asset(
                            'assets/images/logo_white.png',
                            width: 120.w,
                          ),
                        ),
                      ),
                      Text(
                        'Complète votre profile',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontFamily: 'CairoBold',
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
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.2),
                          borderRadius: BorderRadius.circular(360),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 35.h,
                        width: 35.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.2),
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
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          height: 65.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(235, 235, 235, 1),
                            borderRadius: BorderRadius.circular(12),
                            border: _isBirthdayEmpty
                                ? Border.all(
                                    color:
                                        const Color.fromRGBO(231, 230, 235, 1),
                                  )
                                : Border.all(color: Colors.red, width: 2),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: const Icon(
                                  Boxicons.bxs_calendar,
                                  color: Color.fromRGBO(127, 126, 129, 1),
                                ),
                              ),
                              Text(
                                _birthdateController,
                                style: TextStyle(
                                  fontFamily: "CairoSemiBold",
                                  fontSize: 14.sp,
                                  color: _isBirthdayEmpty
                                      ? Theme.of(context).primaryColorDark
                                      : const Color.fromRGBO(127, 126, 129, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        height: 65.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(235, 235, 235, 1),
                          borderRadius: BorderRadius.circular(12),
                          border: !_isSexeEmpty
                              ? Border.all(
                                  color: const Color.fromRGBO(231, 230, 235, 1),
                                )
                              : Border.all(color: Colors.red, width: 2),
                        ),
                        child: SizedBox(
                          height: 65.h,
                          width: 260.w,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<ListItem>(
                                value: _sexe,
                                items: _dropdownSexeItems,
                                style: TextStyle(
                                  fontFamily: "CairoSemiBold",
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                iconSize: 20,
                                icon: const Icon(Boxicons.bxs_chevron_down),
                                iconEnabledColor: Colors.grey[800],
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _sexe = value;
                                      if (_sexe!.value == 'Homme' ||
                                          _sexe!.value == 'Femme') {
                                        _isSexeEmpty = false;
                                      } else {
                                        _isSexeEmpty = true;
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        height: 65.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(235, 235, 235, 1),
                          borderRadius: BorderRadius.circular(12),
                          border: !_isTypeEmpty
                              ? Border.all(
                                  color: const Color.fromRGBO(235, 235, 235, 1),
                                )
                              : Border.all(color: Colors.red, width: 2),
                        ),
                        child: SizedBox(
                          height: 65.h,
                          width: 260.w,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<ListItem>(
                                value: _typeDiabet,
                                items: _dropdownTypeDiabetItems,
                                style: TextStyle(
                                  fontFamily: "CairoSemiBold",
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                iconSize: 20,
                                icon: const Icon(Boxicons.bxs_chevron_down),
                                iconEnabledColor: Colors.grey[800],
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _typeDiabet = value;
                                      if (_typeDiabet!.value == 'Type 1' ||
                                          _typeDiabet!.value == 'Type 2') {
                                        _isTypeEmpty = false;
                                      } else {
                                        _isTypeEmpty = true;
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SizedBox(
                        height: 65.h,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (value) {
                            setState(() {
                              _isCityEmpty = value.isEmpty;
                            });
                          },
                          textCapitalization: TextCapitalization.words,
                          controller: _cityController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            fontFamily: "CairoSemiBold",
                            fontSize: 14.sp,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Boxicons.bxs_map_pin),
                            hintText: 'Ville',
                            hintStyle: TextStyle(
                              fontFamily: "CairoSemiBold",
                              fontSize: 14.sp,
                            ),
                            filled: true,
                            fillColor: const Color.fromRGBO(235, 235, 235, 1),
                            enabledBorder: OutlineInputBorder(
                              borderSide: _isCityEmpty
                                  ? const BorderSide(
                                      color: Colors.red, width: 2)
                                  : BorderSide.none,
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
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 65.h,
                            width: 150.w,
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (value) {
                                setState(() {
                                  _isSizeEmpty = value.isEmpty;
                                });
                              },
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
                                  fontFamily: "CairoSemiBold",
                                  fontSize: 14.sp,
                                ),
                                filled: true,
                                fillColor:
                                    const Color.fromRGBO(235, 235, 235, 1),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: _isSizeEmpty
                                      ? const BorderSide(
                                          color: Colors.red, width: 2)
                                      : BorderSide.none,
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
                            width: 150.w,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  _isWeightEmpty = value.isEmpty;
                                });
                              },
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
                                hintText: 'Poids (kg)',
                                hintStyle: TextStyle(
                                  fontFamily: "CairoSemiBold",
                                  fontSize: 14.sp,
                                ),
                                filled: true,
                                fillColor:
                                    const Color.fromRGBO(235, 235, 235, 1),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: _isWeightEmpty
                                      ? const BorderSide(
                                          color: Colors.red, width: 2)
                                      : BorderSide.none,
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
                    40.verticalSpace,
                    Center(
                      child: InkWell(
                        onTap: () async {
                          validateFields();
                          if (_isBirthdayEmpty &&
                              !_isSexeEmpty &&
                              !_isTypeEmpty &&
                              !_isCityEmpty &&
                              !_isSizeEmpty &&
                              !_isWeightEmpty) {
                            User user = User.fromJson(
                                await SessionManager().get("currentUser"));
                            user.birthdate = _birthdateController;
                            user.sexe = _sexe!.value;
                            user.typeDiabet = _typeDiabet!.value;
                            user.city = _cityController.text;
                            user.weight = _weightController.text;
                            user.size = _sizeController.text;
                            await SessionManager().set('currentUser', user);
                            await Navigator.push(
                              context,
                              PageTransition(
                                child: const CompleteProfileScreenSecond(),
                                type: PageTransitionType.fade,
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

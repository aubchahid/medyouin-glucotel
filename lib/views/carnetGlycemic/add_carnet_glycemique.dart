// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/Tools.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/model/GlycemiqueLog.dart';
import 'package:glucotel/model/ListItem.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/carnetGlycemic/details_carnet_glycemique.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class AddGlycemiqueValue extends StatefulWidget {
  const AddGlycemiqueValue({Key? key}) : super(key: key);

  @override
  State<AddGlycemiqueValue> createState() => _AddGlycemiqueValueState();
}

class _AddGlycemiqueValueState extends State<AddGlycemiqueValue> {
  final TextEditingController _value = TextEditingController();
  final TextEditingController _remarque = TextEditingController();
  List<DropdownMenuItem<ListItem>>? _dropdownTypeItems;
  ListItem? _type;
  String dateD = 'Choisissez la date', time = 'Choisissez l\'heure';
  DateTime selectedDate = DateTime.now();
  User? currentUser;
  GlycemiqueLog? carnet;
  DateTime? startdate, enddate;
  int? id;

  final List<ListItem> _typeItems = [
    ListItem("1", "Avant petit déjeuner"),
    ListItem("2", "Après petit déjeuner"),
    ListItem("3", "Avant déjeuner"),
    ListItem("4", "Après déjeuner"),
    ListItem("5", "Avant dîner"),
    ListItem("6", "Après dîner"),
  ];

  getData() async {
    await Tools().getCurrentUser().then((value) async {
      setState(() {
        currentUser = value;
      });
    });
    carnet = GlycemiqueLog.fromJson(await SessionManager().get('carnet'));
    startdate = DateFormat('dd-MM-yyyy').parse(carnet!.startAt);
    enddate = DateFormat('dd-MM-yyyy').parse(carnet!.endAt);
    id = carnet!.uid;
  }

  _selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: startdate!,
      lastDate: enddate!,
    );
    setState(() {
      dateD = DateFormat("dd-MM-yyyy", "Fr_fr").format(date!).toString();
      selectedDate = date;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    _dropdownTypeItems = Tools().buildDropDownMenuItems(_typeItems);
    _type = _dropdownTypeItems![0].value;
  }

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Tools().showAlertDialogExit(context),
      child: LoadingOverlay(
        isLoading: _loading,
        color: Theme.of(context).primaryColorDark,
        progressIndicator: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 6.0,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const GlycemiqueDetails(),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                },
                child: Icon(
                  Boxicons.bx_chevron_left,
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
                    Boxicons.bx_chevron_down,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  Center(
                    child: Text(
                      'Nouvelle valeur',
                      style: TextStyle(
                        fontFamily: 'CairoSemiBold',
                        fontSize: 18.sp,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      height: 65.h,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (value) {},
                        textCapitalization: TextCapitalization.words,
                        controller: _value,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                        ],
                        style: TextStyle(
                          fontFamily: "CairoSemiBold",
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          label: Text(
                            "Entre votre valeur",
                            style: TextStyle(
                              fontFamily: "CairoSemiBold",
                              fontSize: 14.sp,
                            ),
                          ),
                          filled: true,
                          fillColor: const Color.fromRGBO(235, 235, 235, 1),
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      height: 65.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(235, 235, 235, 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        height: 65.h,
                        width: 260.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<ListItem>(
                              value: _type,
                              items: _dropdownTypeItems,
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
                                    _type = value;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
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
                              dateD,
                              style: TextStyle(
                                fontFamily: "CairoSemiBold",
                                fontSize: 14.sp,
                                color: const Color.fromRGBO(127, 126, 129, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      height: 140.h,
                      child: Align(
                        child: TextField(
                          maxLines: 5,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (value) {},
                          textCapitalization: TextCapitalization.words,
                          controller: _remarque,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                            fontFamily: "CairoSemiBold",
                            fontSize: 14.sp,
                          ),
                          decoration: InputDecoration(
                            label: Text(
                              "Remarque",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "CairoSemiBold",
                                fontSize: 14.sp,
                              ),
                            ),
                            filled: true,
                            fillColor: const Color.fromRGBO(235, 235, 235, 1),
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
                  ),
                  40.verticalSpace,
                  Center(
                    child: InkWell(
                      onTap: () async {
                        if (_value.text.isEmpty) {
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur.",
                              "Veuillez entrer toutes les données requises.");
                        } else if (dateD == "Choisissez la date") {
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur.",
                              "Veuillez entrer toutes les données requises.");
                        } else {
                          setState(() {
                            _loading = true;
                          });
                          String date =
                              DateFormat('dd-MM-yyyy').format(selectedDate);
                          Api()
                              .insertDetails(id, _value.text, date.toString(),
                                  _type!.value, _type!.name, _remarque.text)
                              .then((value) {
                            if (value == "already-exist") {
                              setState(() {
                                _loading = false;
                              });
                              Tools().showDesachievementView(
                                  context,
                                  "Message d'erreur",
                                  "Vous saisissez déjà une valeur avec cette date et cette période");
                            }
                            if (value == "success") {
                              Tools().showAchievementView(
                                  context,
                                  "Enregistré avec succès.",
                                  "Votre valeur a été ajoutée avec succès.");
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  child: const GlycemiqueDetails(),
                                  type: PageTransitionType.rightToLeft,
                                ),
                              );
                            }
                          });
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

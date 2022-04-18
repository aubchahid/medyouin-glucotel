// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/ListItem.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/StatsScreen/glucose_stats_screen.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';

class NewGlucoseStats extends StatefulWidget {
  const NewGlucoseStats({Key? key}) : super(key: key);

  @override
  State<NewGlucoseStats> createState() => _NewGlucoseStatsState();
}

class _NewGlucoseStatsState extends State<NewGlucoseStats> {
  TextEditingController _value = TextEditingController();
  List<DropdownMenuItem<ListItem>>? _dropdownTypeItems;
  ListItem? _type;
  String dateD = 'Choisissez la date', time = 'Choisissez l\'heure';
  DateTime selectedDate = DateTime.now();
  User? currentUser;

  final List<ListItem> _typeItems = [
    ListItem("pre", "Avant repas"),
    ListItem("post", "Après repas"),
  ];

  _selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year + 30),
    );
    setState(() {
      dateD = DateFormat("dd-MM-yyyy", "Fr_fr").format(date!).toString();
      selectedDate = date;
    });
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
      cancelText: 'Annuler',
      helpText: 'Choisissez l\'heure',
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      selectedTime = timeOfDay;
    }
    setState(() {
      time = Tools().formatTimeOfDay(selectedTime);
    });
  }

  getData() async {
    await Tools().getCurrentUser().then((value) async {
      setState(() {
        currentUser = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    _dropdownTypeItems = Tools().buildGlucoseDropDownMenuItems(_typeItems);
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
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const GlucoseStats(),
                      type: PageTransitionType.leftToRight,
                    ),
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  25.verticalSpace,
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
                  25.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      height: 65.h,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        textCapitalization: TextCapitalization.words,
                        controller: _value,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontFamily: "CairoSemiBold",
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          label: Text(
                            "Entre votre valeur",
                            style: TextStyle(
                              fontFamily: "NunitoRegular",
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
                          border: Border.all(
                            color: const Color.fromRGBO(231, 230, 235, 1),
                          ),
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
                  10.verticalSpace,
                  InkWell(
                    onTap: () => _selectTime(context),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        height: 65.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(235, 235, 235, 1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color.fromRGBO(231, 230, 235, 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: const Icon(
                                Boxicons.bxs_time,
                                color: Color.fromRGBO(127, 126, 129, 1),
                              ),
                            ),
                            Text(
                              time,
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
                  10.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      height: 65.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(235, 235, 235, 1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color.fromRGBO(231, 230, 235, 1),
                        ),
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
                  40.verticalSpace,
                  Center(
                    child: InkWell(
                      onTap: () async {
                        if (_value.text.isEmpty) {
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur",
                              "Veuillez entrer toutes les données requises");
                        } else if (dateD == "Choisissez la date") {
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur",
                              "Veuillez entrer toutes les données requises");
                        } else if (time == "Choisissez l'heure") {
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur",
                              "Veuillez entrer toutes les données requises");
                        } else {
                          setState(() {
                            _loading = true;
                          });
                          String hour, day;
                          if (selectedTime.hour < 10) {
                            hour = '0' + selectedTime.hour.toString();
                          } else {
                            hour = selectedTime.hour.toString();
                          }
                          if (selectedDate.day < 10) {
                            day = "0" + selectedDate.day.toString();
                          } else {
                            day = selectedDate.day.toString();
                          }
                          await Api()
                              .insertStats(
                                  currentUser!.id,
                                  _value.text,
                                  dateD,
                                  _type!.value,
                                  hour,
                                  selectedTime.minute.toString(),
                                  day,
                                  selectedDate.month.toString(),
                                  selectedDate.year.toString())
                              .then((value) {
                            if (value == "Success") {
                              Tools().showAchievementView(
                                  context,
                                  "Enregistré avec succès.",
                                  "Votre valeur a été ajoutée avec succès.");
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  child: const GlucoseStats(),
                                  type: PageTransitionType.leftToRight,
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
                          "Ajouter",
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

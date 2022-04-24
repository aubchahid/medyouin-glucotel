// ignore_for_file: file_names, must_be_immutable

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucotel/functions/Tools.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/notification.dart';
import 'package:glucotel/model/ListItem.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/RemindersScreen/mds_screen.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';

class NewRappelScreen extends StatefulWidget {
  const NewRappelScreen({Key? key}) : super(key: key);

  @override
  State<NewRappelScreen> createState() => _NewRappelScreenState();
}

class _NewRappelScreenState extends State<NewRappelScreen> {
  bool _isMeds = false, everyDay = false, _isType = false, _isLoading = false;
  double shapePointerValue = 0;

  final TextEditingController _aboutController = TextEditingController();
  List<DropdownMenuItem<ListItem>>? _dropdownTypeItems;
  ListItem? _type;
  Color color = const Color.fromRGBO(104, 103, 106, 1);
  late User? currentUser;

  getData() async {
    await Tools().getCurrentUser().then((value) async {
      currentUser = value;
    });
  }

  final List<ListItem> _typeItem = [
    ListItem("-", "Type de rappel"),
    ListItem("Médicament", "Médicament"),
    ListItem("Insuline", "Insuline"),
  ];

  bool isHalf = false, isOne = false, isOneAndHalf = false, isTwo = false;

  String dateD = 'Choisissez la date', time = 'Choisissez l\'heure';
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
      color = Theme.of(context).primaryColorDark;
    });
  }

  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(selectedDate.year + 30),
    );
    setState(() {
      dateD = DateFormat.yMd().format(date!).toString();
      selectedDate = date;
      color = Theme.of(context).primaryColorDark;
    });
  }

  int insulineIntake = 0;
  double qte = 0;

  @override
  void initState() {
    super.initState();
    _dropdownTypeItems = Tools().buildDropDownMenuItems(_typeItem);
    _type = _dropdownTypeItems![0].value;
    getData();
    setState(() {
      qte = 0;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      color: Theme.of(context).primaryColorDark,
      progressIndicator: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
        strokeWidth: 6.0,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: const MedsScreen(),
                    type: PageTransitionType.fade,
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
                30.verticalSpace,
                Center(
                  child: Text(
                    'Nouveau rappel',
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                30.verticalSpace,
                Padding(
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
                            FontAwesomeIcons.exclamation,
                            color: Color.fromRGBO(127, 126, 129, 1),
                          ),
                        ),
                        SizedBox(
                          height: 65.h,
                          width: 280.w,
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
                                    if (_type!.value == "-") {
                                      _isType = false;
                                      _isMeds = false;
                                    } else if (_type!.value == 'Médicament') {
                                      _isMeds = true;
                                      _isType = true;
                                      _aboutController.text = "";
                                    } else {
                                      _isMeds = false;
                                      _isType = true;
                                      setState(() {
                                        insulineIntake = 2;
                                      });
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _isMeds ? 10.verticalSpace : Container(),
                _isMeds
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 65.h,
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            textCapitalization: TextCapitalization.words,
                            controller: _aboutController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontFamily: "CairoSemiBold",
                              fontSize: 14.sp,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(FontAwesomeIcons.bookmark),
                              hintText: 'Rappelle-moi de ...',
                              hintStyle: TextStyle(
                                fontFamily: "CairoSemiBold",
                                fontSize: 14.sp,
                              ),
                              filled: true,
                              fillColor: const Color.fromRGBO(235, 235, 235, 1),
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
                      )
                    : Container(),
                _isType ? 10.verticalSpace : Container(),
                _isType
                    ? _isMeds
                        ? Column(
                            children: [
                              10.verticalSpace,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Quantité',
                                    style: TextStyle(
                                      fontFamily: "CairoSemiBold",
                                      fontSize: 14.sp,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                                ),
                              ),
                              10.verticalSpace,
                              SizedBox(
                                height: 60.h,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isOne = isTwo = isOneAndHalf = false;
                                          isHalf = true;
                                          qte = 0.5;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        child: Container(
                                          height: 60.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            color: isHalf
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .primaryColor
                                                    .withAlpha(60),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '0.5',
                                            style: TextStyle(
                                              fontFamily: "CairoSemiBold",
                                              fontSize: 14.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isHalf = isTwo = isOneAndHalf = false;
                                          isOne = true;
                                          qte = 1;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        child: Container(
                                          height: 60.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            color: isOne
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .primaryColor
                                                    .withAlpha(60),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                              fontFamily: "CairoSemiBold",
                                              fontSize: 14.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isHalf = isOne = isTwo = false;
                                          isOneAndHalf = true;
                                          qte = 1.5;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        child: Container(
                                          height: 60.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            color: isOneAndHalf
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .primaryColor
                                                    .withAlpha(60),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '1.5',
                                            style: TextStyle(
                                              fontFamily: "CairoSemiBold",
                                              fontSize: 14.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isHalf = isOne = isOneAndHalf = false;
                                          isTwo = true;
                                          qte = 2;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        child: Container(
                                          height: 60.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                            color: isTwo
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .primaryColor
                                                    .withAlpha(60),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                              fontFamily: "CairoSemiBold",
                                              fontSize: 14.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Quantité',
                                    style: TextStyle(
                                      fontFamily: "CairoSemiBold",
                                      fontSize: 14.sp,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                                ),
                              ),
                              10.verticalSpace,
                              SizedBox(
                                height: 60.h,
                                width: 200.w,
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        if (insulineIntake > 2) {
                                          setState(() {
                                            insulineIntake = insulineIntake - 2;
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 50.h,
                                        width: 50.h,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Icon(
                                          Boxicons.bx_minus,
                                          color: Colors.white,
                                          size: 35.h,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: 100.w,
                                      child: Text(
                                        insulineIntake.toStringAsFixed(0),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "CairoSemiBold",
                                          fontSize: 18.sp,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        if (insulineIntake < 30) {
                                          setState(() {
                                            insulineIntake = insulineIntake + 2;
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 50.h,
                                        width: 50.h,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Icon(
                                          Boxicons.bx_plus,
                                          color: Colors.white,
                                          size: 35.h,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ],
                          )
                    : Container(),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(235, 235, 235, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.solidClock,
                              color: Color.fromRGBO(104, 103, 106, 1),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              time,
                              style: TextStyle(
                                fontFamily: "CairoSemiBold",
                                fontSize: 14.sp,
                                color: color,
                              ),
                            ),
                          ],
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
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(235, 235, 235, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.calendar,
                              color: Color.fromRGBO(104, 103, 106, 1),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              dateD,
                              style: TextStyle(
                                fontFamily: "CairoSemiBold",
                                fontSize: 14.sp,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          'Rappelez-moi tous les jours',
                          style: TextStyle(
                            fontFamily: "CairoSemiBold",
                            fontSize: 14.sp,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: everyDay,
                          onChanged: (value) {
                            setState(() {
                              everyDay = value;
                            });
                          },
                          activeTrackColor:
                              const Color.fromRGBO(113, 184, 177, 1),
                          activeColor: const Color.fromRGBO(0, 142, 129, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                40.verticalSpace,
                Center(
                  child: InkWell(
                    onTap: () async {
                      bool valid = true;
                      if (_type!.value == "-") {
                        valid = false;
                        Tools().showDesachievementView(
                            context,
                            "Message d'erreur",
                            "Veuillez compléter toutes les données.");
                      } else if (_type!.value == "Médicament") {
                        if (_aboutController.text.isEmpty) {
                          valid = false;
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur",
                              "Veuillez compléter toutes les données.");
                        } else if (qte == 0) {
                          valid = false;
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur",
                              "Veuillez compléter toutes les données.");
                        } else if (time == "Choisissez l'heure") {
                          valid = false;
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur",
                              "Veuillez compléter toutes les données.");
                        } else if (dateD == "Choisissez la date") {
                          valid = false;
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur",
                              "Veuillez compléter toutes les données.");
                        }
                      } else if (_type!.value == "Insuline") {
                        if (time == "Choisissez l'heure") {
                          valid = false;
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur",
                              "Veuillez compléter toutes les données.");
                        } else if (dateD == "Choisissez la date") {
                          valid = false;
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur",
                              "Veuillez compléter toutes les données.");
                        }
                      }
                      if (selectedDate.year == DateTime.now().year &&
                          selectedDate.month == DateTime.now().month &&
                          selectedDate.day == DateTime.now().day) {
                        if (selectedTime.hour <= DateTime.now().hour) {
                          if (selectedTime.minute <= DateTime.now().minute) {
                            valid = false;
                            Tools().showDesachievementView(
                                context,
                                "Message d'erreur",
                                "Veuillez changer la date à une date future.");
                          } else {
                            valid = true;
                          }
                        }
                      }
                      if (valid) {
                        setState(() {
                          _isLoading = true;
                        });
                        DateTime dt = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );

                        String sousType = "mds";
                        if (_type!.value == "Insuline") {
                          sousType = "in";
                        }
                        String text = "";
                        _aboutController.text.isEmpty
                            ? text = "Prendre " +
                                insulineIntake.toStringAsFixed(0) +
                                " Unités d’insuline"
                            : text = "Prendre " +
                                qte.toStringAsFixed(0) +
                                " comprimés de " +
                                _aboutController.text;
                        double qa = 0;
                        qte == 0
                            ? qa = double.parse(insulineIntake.toString())
                            : qa = qte;
                        await Api()
                            .insertReminder(currentUser?.id, time, dateD, text,
                                qa.toString(), sousType)
                            .then((value) async {
                          NotificationService()
                              .scheduleNotification(
                            int.parse(value),
                            dt,
                            "Glucotel",
                            text,
                            'mds',
                            everyDay: everyDay,
                          )
                              .then(
                            (value) {
                              Tools().showAchievementView(
                                  context,
                                  "Ajouté avec succès.",
                                  "Votre alert medical a été ajouté avec succès.");
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  child: const MedsScreen(),
                                  type: PageTransitionType.rightToLeft,
                                ),
                              );
                            },
                          );
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
    );
  }
}

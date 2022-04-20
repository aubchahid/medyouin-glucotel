// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/Glucose.dart';
import 'package:glucotel/model/ListItem.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/StatsScreen/new_glucose_screen.dart';
import 'package:glucotel/views/mainScreens/main_screen.dart';

import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class GlucoseStats extends StatefulWidget {
  const GlucoseStats({Key? key}) : super(key: key);

  @override
  State<GlucoseStats> createState() => _GlucoseStatsState();
}

class _GlucoseStatsState extends State<GlucoseStats> {
  bool daily = true, weekly = false, monthly = false;
  User? currentUser;
  List<BarChartGroupData> values = [];
  List<Glucose> glucose = [], glucoseWeekly = [], glucoseMonthly = [];
  List<Glucose> _daily = [], _weekly = [], _monthly = [], _archive = [];
  bool? _isLoad = true;
  DateTime selectedDate = DateTime.now();
  late String date;

  List<DropdownMenuItem<ListItem>>? _dropdownTypeItems;
  ListItem? _type;

  final List<ListItem> _typeItems = [
    ListItem("pre", "Avant repas"),
    ListItem("post", "Après repas"),
  ];

  Future<bool> getData() async {
    await Tools().getCurrentUser().then((value) async {
      setState(() {
        currentUser = value;
      });
    });
    await Api().selectStats(currentUser!.id).then((value) {
      setState(() {
        glucose = value;
      });
    });
    await Api().weeklyStats(currentUser!.id).then((value) {
      setState(() {
        _weekly = value;
      });
    });
    await Api().monthlyStats(currentUser!.id).then((value) {
      setState(() {
        _monthly = value;
      });
    });
    _archive = _daily = glucose.where((element) {
      return element.date ==
              DateFormat("dd-MM-yyyy", "Fr_fr").format(selectedDate) &&
          element.period == _type!.value;
    }).toList();
    for (var i = 0; i < _daily.length; i++) {
      Color colors = Colors.white;
      if (_daily[i].period == "post") {
        if (double.parse(_daily[i].value) <
            double.parse(currentUser!.glycPostMealT1)) {
          colors = const Color.fromRGBO(235, 35, 46, 1);
        }
        if (double.parse(_daily[i].value) >=
                double.parse(currentUser!.glycPostMealT1) &&
            double.parse(_daily[i].value) <
                double.parse(currentUser!.glycPostMealT2)) {
          colors = const Color.fromRGBO(111, 193, 34, 1);
        }
        if (double.parse(_daily[i].value) >=
                double.parse(currentUser!.glycPostMealT2) &&
            double.parse(_daily[i].value) <
                double.parse(currentUser!.glycPostMealT3)) {
          colors = const Color.fromRGBO(251, 187, 43, 1);
        }
        if (double.parse(_daily[i].value) >=
            double.parse(currentUser!.glycPostMealT3)) {
          colors = const Color.fromRGBO(248, 99, 0, 1);
        }
      }
      if (_daily[i].period == "pre") {
        if (double.parse(_daily[i].value) <
            double.parse(currentUser!.glycPreMealT1)) {
          colors = const Color.fromRGBO(235, 35, 46, 1);
        }
        if (double.parse(_daily[i].value) >=
                double.parse(currentUser!.glycPreMealT1) &&
            double.parse(_daily[i].value) <
                double.parse(currentUser!.glycPreMealT2)) {
          colors = const Color.fromRGBO(111, 193, 34, 1);
        }
        if (double.parse(_daily[i].value) >=
                double.parse(currentUser!.glycPreMealT2) &&
            double.parse(_daily[i].value) <
                double.parse(currentUser!.glycPreMealT3)) {
          colors = const Color.fromRGBO(251, 187, 43, 1);
        }
        if (double.parse(_daily[i].value) >=
            double.parse(currentUser!.glycPreMealT3)) {
          colors = const Color.fromRGBO(248, 99, 0, 1);
        }
      }
      int hour = int.parse("2" + _daily[i].hour);
      BarChartGroupData bar = BarChartGroupData(
        x: hour,
        barRods: [
          BarChartRodData(
            y: double.parse(_daily[i].value.toString()),
            colors: [colors],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
            ),
          )
        ],
        showingTooltipIndicators: [0],
      );
      setState(() {
        values.add(bar);
      });
    }
    return Future.value(false);
  }

  setDaily(dateSelected) async {
    setState(() {
      _daily.clear();
      values.clear();
      _archive = _daily = glucose.where((element) {
        return element.date ==
                DateFormat("dd-MM-yyyy", "Fr_fr").format(dateSelected) &&
            element.period == _type!.value;
      }).toList();
    });
    for (var i = 0; i < _daily.length; i++) {
      Color colors = Colors.white;
      if (_daily[i].period == "post") {
        if (double.parse(_daily[i].value) <
            double.parse(currentUser!.glycPostMealT1)) {
          colors = const Color.fromRGBO(235, 35, 46, 1);
        }
        if (double.parse(_daily[i].value) >=
                double.parse(currentUser!.glycPostMealT1) &&
            double.parse(_daily[i].value) <
                double.parse(currentUser!.glycPostMealT2)) {
          colors = const Color.fromRGBO(111, 193, 34, 1);
        }
        if (double.parse(_daily[i].value) >=
                double.parse(currentUser!.glycPostMealT2) &&
            double.parse(_daily[i].value) <
                double.parse(currentUser!.glycPostMealT3)) {
          colors = const Color.fromRGBO(251, 187, 43, 1);
        }
        if (double.parse(_daily[i].value) >=
            double.parse(currentUser!.glycPostMealT3)) {
          colors = const Color.fromRGBO(248, 99, 0, 1);
        }
      }
      if (_daily[i].period == "pre") {
        if (double.parse(_daily[i].value) <
            double.parse(currentUser!.glycPreMealT1)) {
          colors = const Color.fromRGBO(235, 35, 46, 1);
        }
        if (double.parse(_daily[i].value) >=
                double.parse(currentUser!.glycPreMealT1) &&
            double.parse(_daily[i].value) <
                double.parse(currentUser!.glycPreMealT2)) {
          colors = const Color.fromRGBO(111, 193, 34, 1);
        }
        if (double.parse(_daily[i].value) >=
                double.parse(currentUser!.glycPreMealT2) &&
            double.parse(_daily[i].value) <
                double.parse(currentUser!.glycPreMealT3)) {
          colors = const Color.fromRGBO(251, 187, 43, 1);
        }
        if (double.parse(_daily[i].value) >=
            double.parse(currentUser!.glycPreMealT3)) {
          colors = const Color.fromRGBO(248, 99, 0, 1);
        }
      }
      int hour = int.parse("2" + _daily[i].hour);
      BarChartGroupData bar = BarChartGroupData(
        x: hour,
        barRods: [
          BarChartRodData(
            y: double.parse(_daily[i].value.toString()),
            colors: [colors],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
            ),
          )
        ],
        showingTooltipIndicators: [0],
      );
      setState(() {
        values.add(bar);
      });
    }
  }

  setWeekly(dateSelected) async {
    setState(() {
      values.clear();
      _archive = glucoseWeekly = _weekly.where((element) {
        return dateSelected
                    .difference(DateTime(int.parse(element.year),
                        int.parse(element.month), int.parse(element.day)))
                    .inDays <=
                6 &&
            dateSelected
                    .subtract(const Duration(days: 1))
                    .difference(DateTime(int.parse(element.year),
                        int.parse(element.month), int.parse(element.day)))
                    .inDays >=
                0 &&
            element.period == _type!.value;
      }).toList();
    });
    for (var i = 0; i < _archive.length; i++) {
      Color colors = Colors.white;
      if (_archive[i].period == "post") {
        if (double.parse(_archive[i].value) <
            double.parse(currentUser!.glycPostMealT1)) {
          colors = const Color.fromRGBO(235, 35, 46, 1);
        }
        if (double.parse(_archive[i].value) >=
                double.parse(currentUser!.glycPostMealT1) &&
            double.parse(_archive[i].value) <
                double.parse(currentUser!.glycPostMealT2)) {
          colors = const Color.fromRGBO(111, 193, 34, 1);
        }
        if (double.parse(_archive[i].value) >=
                double.parse(currentUser!.glycPostMealT2) &&
            double.parse(_archive[i].value) <
                double.parse(currentUser!.glycPostMealT3)) {
          colors = const Color.fromRGBO(251, 187, 43, 1);
        }
        if (double.parse(_archive[i].value) >=
            double.parse(currentUser!.glycPostMealT3)) {
          colors = const Color.fromRGBO(248, 99, 0, 1);
        }
      }
      if (_archive[i].period == "pre") {
        if (double.parse(_archive[i].value) <
            double.parse(currentUser!.glycPreMealT1)) {
          colors = const Color.fromRGBO(235, 35, 46, 1);
        }
        if (double.parse(_archive[i].value) >=
                double.parse(currentUser!.glycPreMealT1) &&
            double.parse(_archive[i].value) <
                double.parse(currentUser!.glycPreMealT2)) {
          colors = const Color.fromRGBO(111, 193, 34, 1);
        }
        if (double.parse(_archive[i].value) >=
                double.parse(currentUser!.glycPreMealT2) &&
            double.parse(_archive[i].value) <
                double.parse(currentUser!.glycPreMealT3)) {
          colors = const Color.fromRGBO(251, 187, 43, 1);
        }
        if (double.parse(glucoseWeekly[i].value) >=
            double.parse(currentUser!.glycPreMealT3)) {
          colors = const Color.fromRGBO(248, 99, 0, 1);
        }
      }
      int hour;
      if (int.parse(_archive[i].day) > 10) {
        hour = int.parse("1" + _archive[i].day);
      } else {
        hour = int.parse("10" + _archive[i].day);
      }
      BarChartGroupData bar = BarChartGroupData(
        x: hour,
        barRods: [
          BarChartRodData(
            y: double.parse(glucoseWeekly[i].value.toString()),
            colors: [colors],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
            ),
          )
        ],
        showingTooltipIndicators: [0],
      );
      setState(() {
        values.add(bar);
      });
    }
  }

  setMonthly(dateSelected) async {
    setState(() {
      values.clear();
      _archive = glucoseMonthly = _monthly.where((element) {
        return element.period == _type!.value;
      }).toList();
    });
    for (var i = 0; i < glucoseMonthly.length; i++) {
      Color colors = Colors.white;
      if (glucoseMonthly[i].period == "post") {
        if (double.parse(glucoseMonthly[i].value) <
            double.parse(currentUser!.glycPostMealT1)) {
          colors = const Color.fromRGBO(235, 35, 46, 1);
        }
        if (double.parse(glucoseMonthly[i].value) >=
                double.parse(currentUser!.glycPostMealT1) &&
            double.parse(glucoseMonthly[i].value) <
                double.parse(currentUser!.glycPostMealT2)) {
          colors = const Color.fromRGBO(111, 193, 34, 1);
        }
        if (double.parse(glucoseMonthly[i].value) >=
                double.parse(currentUser!.glycPostMealT2) &&
            double.parse(glucoseMonthly[i].value) <
                double.parse(currentUser!.glycPostMealT3)) {
          colors = const Color.fromRGBO(251, 187, 43, 1);
        }
        if (double.parse(glucoseMonthly[i].value) >=
            double.parse(currentUser!.glycPostMealT3)) {
          colors = const Color.fromRGBO(248, 99, 0, 1);
        }
      }
      if (glucoseMonthly[i].period == "pre") {
        if (double.parse(glucoseMonthly[i].value) <
            double.parse(currentUser!.glycPreMealT1)) {
          colors = const Color.fromRGBO(235, 35, 46, 1);
        }
        if (double.parse(glucoseMonthly[i].value) >=
                double.parse(currentUser!.glycPreMealT1) &&
            double.parse(glucoseMonthly[i].value) <
                double.parse(currentUser!.glycPreMealT2)) {
          colors = const Color.fromRGBO(111, 193, 34, 1);
        }
        if (double.parse(glucoseMonthly[i].value) >=
                double.parse(currentUser!.glycPreMealT2) &&
            double.parse(glucoseMonthly[i].value) <
                double.parse(currentUser!.glycPreMealT3)) {
          colors = const Color.fromRGBO(251, 187, 43, 1);
        }
        if (double.parse(glucoseMonthly[i].value) >=
            double.parse(currentUser!.glycPreMealT3)) {
          colors = const Color.fromRGBO(248, 99, 0, 1);
        }
      }
      int hour = int.parse(glucoseMonthly[i].month);
      BarChartGroupData bar = BarChartGroupData(
        x: hour,
        barRods: [
          BarChartRodData(
              y: double.parse(glucoseMonthly[i].value.toString()),
              colors: [colors])
        ],
        showingTooltipIndicators: [0],
      );
      setState(() {
        values.add(bar);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    date = DateFormat("dd MMM yyyy", "Fr_fr").format(selectedDate);
    _dropdownTypeItems = Tools().buildGlucoseDropDownMenuItems(_typeItems);
    _type = _dropdownTypeItems![0].value;
    getData().then((value) {
      setState(() {
        _isLoad = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Tools().showAlertDialogExit(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: const MainScreen(index: 1),
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
          floatingActionButton: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: const NewGlucoseStats(),
                  type: PageTransitionType.leftToRight,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 22.w,
                    height: 45.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Ajouter",
                      style: TextStyle(
                        fontFamily: 'CairoRegular',
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 22.w,
                    height: 45.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Estimation hba1c",
                      style: TextStyle(
                        fontFamily: 'CairoRegular',
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: _isLoad!
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Statistiques de glycémie",
                          style: TextStyle(
                            fontFamily: 'CairoRegular',
                            fontSize: 16.sp,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (!daily) {
                                  setState(() {
                                    daily = true;
                                    weekly = false;
                                    monthly = false;
                                    date = DateFormat("dd MMMM yyyy", "Fr_fr")
                                        .format(selectedDate);
                                    setDaily(selectedDate);
                                  });
                                }
                              },
                              child: Container(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    25.w,
                                height: 45.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: daily
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'Quotidien',
                                  style: TextStyle(
                                    fontFamily: 'CairoRegular',
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                if (!weekly) {
                                  setState(() {
                                    daily = false;
                                    weekly = true;
                                    monthly = false;
                                    date = DateFormat("dd MMM yy", "Fr_fr")
                                            .format(selectedDate.subtract(
                                                const Duration(days: 7))) +
                                        "   -   " +
                                        DateFormat("dd MMM yy", "Fr_fr")
                                            .format(selectedDate);
                                    setWeekly(selectedDate);
                                  });
                                }
                              },
                              child: Container(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    25.w,
                                height: 45.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: weekly
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'Hebdomadaire',
                                  style: TextStyle(
                                    fontFamily: 'CairoRegular',
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      monthly
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                height: 55.h,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: Row(
                                    children: [
                                      SizedBox(width: 7.5.w),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (daily) {
                                              selectedDate =
                                                  selectedDate.subtract(
                                                      const Duration(days: 1));
                                              date = DateFormat(
                                                      "dd MMM yyyy", "Fr_fr")
                                                  .format(selectedDate);
                                              setDaily(selectedDate);
                                            }
                                            if (weekly) {
                                              selectedDate =
                                                  selectedDate.subtract(
                                                      const Duration(days: 7));
                                              date = DateFormat(
                                                          "dd MMM yy", "Fr_fr")
                                                      .format(
                                                          selectedDate.subtract(
                                                              const Duration(
                                                                  days: 6))) +
                                                  "   -   " +
                                                  DateFormat(
                                                          "dd MMM yy", "Fr_fr")
                                                      .format(selectedDate);
                                              setWeekly(selectedDate);
                                            }
                                            if (monthly) {
                                              selectedDate = DateTime(
                                                  selectedDate.year,
                                                  selectedDate.month - 1);
                                              date =
                                                  DateFormat("MMMM yy", "Fr_fr")
                                                      .format(selectedDate);
                                              setMonthly(selectedDate);
                                            }
                                          });
                                        },
                                        child: Icon(
                                          Boxicons.bxs_chevron_left,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          //Tools().floatDateTime(context);
                                        },
                                        child: Text(
                                          date,
                                          style: TextStyle(
                                            fontFamily: 'CairoRegular',
                                            fontSize: 16.sp,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (daily) {
                                              selectedDate = selectedDate
                                                  .add(const Duration(days: 1));
                                              date = DateFormat(
                                                      "dd MMM yyyy", "Fr_fr")
                                                  .format(selectedDate);
                                              setDaily(selectedDate);
                                            }
                                            if (weekly) {
                                              date = DateFormat(
                                                          "dd MMM yy", "Fr_fr")
                                                      .format(selectedDate.add(
                                                          const Duration(
                                                              days: 1))) +
                                                  "   -   " +
                                                  DateFormat(
                                                          "dd MMM yy", "Fr_fr")
                                                      .format(selectedDate.add(
                                                          const Duration(
                                                              days: 7)));
                                              selectedDate = selectedDate
                                                  .add(const Duration(days: 7));
                                              setWeekly(selectedDate);
                                            }
                                            if (monthly) {
                                              selectedDate = DateTime(
                                                  selectedDate.year,
                                                  selectedDate.month + 1);
                                              date =
                                                  DateFormat("MMMM yy", "Fr_fr")
                                                      .format(selectedDate);
                                              setMonthly(selectedDate);
                                            }
                                          });
                                        },
                                        child: Icon(
                                          Boxicons.bxs_chevron_right,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      SizedBox(width: 7.5.w),
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
                          height: 65.h,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: SizedBox(
                                    height: 65.h,
                                    width: MediaQuery.of(context).size.width -
                                        70.w,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<ListItem>(
                                        value: _type,
                                        items: _dropdownTypeItems,
                                        style: TextStyle(
                                          fontFamily: "CairoSemiBold",
                                          fontSize: 14.sp,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                        iconSize: 20,
                                        icon: const Icon(
                                            Boxicons.bxs_chevron_down),
                                        iconEnabledColor: Colors.grey[800],
                                        isExpanded: true,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              _type = value;
                                              if (daily) {
                                                setDaily(selectedDate);
                                              }
                                              if (weekly) {
                                                setWeekly(selectedDate);
                                              }
                                              if (monthly) {
                                                setMonthly(selectedDate);
                                              }
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
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 250.h,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 25.h,
                                  bottom: 10.h,
                                  left: 5.w,
                                  right: 5.w),
                              child: _archive.isNotEmpty
                                  ? BarChart(
                                      BarChartData(
                                        barTouchData: barTouchData,
                                        titlesData: titlesData,
                                        borderData: borderData,
                                        barGroups: values,
                                        alignment:
                                            BarChartAlignment.spaceAround,
                                        maxY: 4,
                                        gridData: FlGridData(show: false),
                                      ),
                                    )
                                  : Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              "assets/images/icon.png",
                                              height: 120.h,
                                            ),
                                            const Spacer(),
                                            Text(
                                              "Ajouter les valeurs de votre mesure quotidienne de glycémie",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                fontFamily: 'CairoRegular',
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          "Détails",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontFamily: 'CairoSemiBold',
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 110.h,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: _archive.length,
                            itemBuilder: (_, i) {
                              return SizedBox(
                                height: 110.h,
                                width: 110.h,
                                child: InkWell(
                                  onTap: () {},
                                  child: Card(
                                    child: Column(
                                      children: [
                                        const Spacer(),
                                        Text(
                                          _archive[i].day +
                                              '-' +
                                              _archive[i].month +
                                              '-' +
                                              _archive[i].year,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            fontFamily: 'CairoSemiBold',
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          _archive[i].hour +
                                              ':' +
                                              _archive[i].minute,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            fontFamily: 'CairoSemiBold',
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          _archive[i].value + "g/l",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            fontFamily: 'CairoSemiBold',
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.toString(),
              TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontFamily: 'CairoRegular',
                fontSize: 12.sp,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: 14.sp,
            fontFamily: 'CairoSemiBold',
          ),
          margin: 20,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 1:
                return 'Jan.';
              case 2:
                return 'Fév';
              case 3:
                return 'Mar.';
              case 4:
                return 'Avr.';
              case 5:
                return 'Mai';
              case 6:
                return 'Jui.';
              case 7:
                return 'Juil.';
              case 8:
                return 'Aou.';
              case 9:
                return 'Sep.';
              case 10:
                return 'Oct.';
              case 11:
                return 'Nov.';
              case 12:
                return 'Déc.';
              case 101:
                return '1';
              case 102:
                return '2';
              case 103:
                return '3';
              case 104:
                return '4';
              case 105:
                return '5';
              case 106:
                return '6';
              case 107:
                return '7';
              case 108:
                return '8';
              case 109:
                return '9';
              case 110:
                return '10';
              case 111:
                return '11';
              case 112:
                return '12';
              case 113:
                return '13';
              case 114:
                return '14';
              case 115:
                return '15';
              case 116:
                return '16';
              case 117:
                return '17';
              case 118:
                return '18';
              case 119:
                return '19';
              case 120:
                return '20';
              case 121:
                return '21';
              case 122:
                return '22';
              case 123:
                return '23';
              case 124:
                return '24';
              case 125:
                return '25';
              case 126:
                return '26';
              case 127:
                return '27';
              case 128:
                return '28';
              case 129:
                return '29';
              case 130:
                return '30';
              case 131:
                return '31';
              case 200:
                return '00H';
              case 201:
                return '01H';
              case 202:
                return '02H';
              case 203:
                return '03H';
              case 204:
                return '04H';
              case 205:
                return '05H';
              case 206:
                return '06H';
              case 207:
                return '07H';
              case 208:
                return '08H';
              case 209:
                return '09H';
              case 210:
                return '10H';
              case 211:
                return '11H';
              case 212:
                return '12H';
              case 213:
                return '13H';
              case 214:
                return '14H';
              case 215:
                return '15H';
              case 216:
                return '16H';
              case 217:
                return '17H';
              case 218:
                return '18H';
              case 219:
                return '19H';
              case 220:
                return '20H';
              case 221:
                return '21H';
              case 222:
                return '22H';
              case 223:
                return '23H';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          interval: 2,
          showTitles: true,
          getTextStyles: (context, value) => TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontSize: 14.sp,
            fontFamily: 'CairoSemiBold',
          ),
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          left: BorderSide(
            color: Colors.black,
            width: 0.7.w,
          ),
          bottom: BorderSide(
            color: Colors.black,
            width: 0.7.w,
          ),
        ),
      );
}

// ignore_for_file: file_names

import 'dart:async';

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/Functions/Tools.dart';
import 'package:glucotel/functions/Notification.dart';
import 'package:glucotel/model/WaterReminder.dart';
import 'package:glucotel/views/RemindersScreen/water_reminder.dart';
import 'package:glucotel/views/mainScreens/main_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';

class WaterReminderResultat extends StatefulWidget {
  const WaterReminderResultat({Key? key}) : super(key: key);

  @override
  State<WaterReminderResultat> createState() => _WaterReminderResultatState();
}

class _WaterReminderResultatState extends State<WaterReminderResultat> {
  double intake = 0;
  WaterReminder? waterReminder;
  bool isToday = false;
  double? dailyQte;

  Future<WaterReminder> getData() async {
    WaterReminder wt =
        WaterReminder.fromJson(await SessionManager().get('waterReminder'));
    setState(() {
      dailyQte = wt.dailyQte;
    });
    return wt;
  }

  dailyClean(date) async {
    String todayDate = DateFormat.yMd().format(DateTime.now()).toString();
    if (date != todayDate) {
      if (!isToday) {
        setState(() {
          intake = 0;
          isToday = true;
          waterReminder!.intake = "0";
          waterReminder!.date = todayDate;
        });
      }
    }
  }

  int i = 3;

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        waterReminder = value;
        intake = double.parse(waterReminder!.intake);
      });
      dailyClean(waterReminder!.date);
    });
  }

  List<String> textItem = [
    'Buvez lentement votre verre d’eau en quelques petites gorgées.',
    'Ne buvez pas d’eau froide ou glacée.',
    'Ne buvez pas d’eau immédiatement après avoir mangé.',
    'Ne buvez pas d’eau froide immédiatement après des boissons chaudes comme du thé ou du café.',
    'Buvez toujours de l’eau avant d’urinez et ne la buvez pas immédiatement après avoir uriner.',
    'Garder l’eau dans votre bouche pendant un moment avant d’avaler',
  ];

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
                  screen: const MainScreen(index: 2),
                  pageTransitionAnimation: PageTransitionAnimation.slideRight,
                );
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
          body: waterReminder == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Rappel de l’eau",
                      style: TextStyle(
                        fontFamily: "CairoBold",
                        fontSize: 18.sp,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Container(
                            height: 75.h,
                            width: 240.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                textItem[i],
                                style: TextStyle(
                                  fontFamily: "CairoBold",
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColorDark,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Image.asset(
                            "assets/images/drop_water_talkin.png",
                            width: 80.w,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Center(
                      child: SizedBox(
                        height: 250.h,
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              showLabels: false,
                              showAxisLine: true,
                              showTicks: false,
                              axisLineStyle: const AxisLineStyle(thickness: 20),
                              minimum: 0,
                              maximum: dailyQte!,
                              pointers: <GaugePointer>[
                                RangePointer(
                                  value: intake,
                                  width: 0.20,
                                  color: Theme.of(context).primaryColor,
                                  sizeUnit: GaugeSizeUnit.factor,
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  widget: StatefulBuilder(
                                    builder: (i, index) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Spacer(),
                                          Text(
                                            intake.toStringAsFixed(0) +
                                                '/' +
                                                dailyQte!.toStringAsFixed(0) +
                                                ' ml',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'CairoSemiBold',
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                                          Text(
                                            'Objectif quotidien',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'CairoSemiBold',
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      );
                                    },
                                  ),
                                  angle: 90,
                                  positionFactor: 0.1,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          intake = intake + 300;
                          if (i == 0) {
                            i = 1;
                          }
                          if (i == 1) {
                            i = 3;
                          }
                          if (i == 2) {
                            i = 4;
                          }
                          if (i == 3) {
                            i = 2;
                          }
                          if (i == 4) {
                            i = 0;
                          }
                        });
                        if (waterReminder!.daily) {
                          if (intake >= waterReminder!.dailyQte) {
                            waterReminder!.daily = false;
                            NotificationService().showNotification(
                              waterReminder!.uid,
                              "Rappel de l'eau",
                              "Vous avez atteint l'objectif du jour 🎉",
                            );
                          }
                        }
                        waterReminder!.intake = intake.toString();
                        await SessionManager()
                            .set("waterReminder", waterReminder);
                      },
                      child: Container(
                        height: 45.h,
                        width: 45.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Boxicons.bx_plus,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Confirmez que vous venez de boire de l'eau",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'CairoSemiBold',
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const Spacer(),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const WaterReminderScreen(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        child: Container(
                          height: 55.h,
                          width: 280.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Calculez votre besoin quotidien en eau",
                            style: TextStyle(
                              fontFamily: 'CairoBold',
                              fontSize: 14.sp,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

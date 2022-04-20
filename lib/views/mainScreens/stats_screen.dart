// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/Tools.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/model/GlycemiqueLog.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/StatsScreen/glucose_stats_screen.dart';
import 'package:glucotel/views/hba1c/hba1c_first_screen.dart';
import 'package:glucotel/views/hba1c/hba1c_resultat_screen.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MyStats extends StatefulWidget {
  const MyStats({Key? key}) : super(key: key);

  @override
  State<MyStats> createState() => _MyStatsState();
}

class _MyStatsState extends State<MyStats> {
  DateTime dateTime = DateTime.now();
  User? currentUser;
  bool isLoading = false;
  double? value;
  String? lastValue;

  double? hba1c;

  returnValuePin(value) {
    double val = 0;
    if (double.parse(value) < double.parse(currentUser!.glycPostMealT1)) {
      val = 0.5;
    }
    if (double.parse(value) >= double.parse(currentUser!.glycPostMealT1) &&
        double.parse(value) < double.parse(currentUser!.glycPostMealT2)) {
      val = 1.5;
    }
    if (double.parse(value) >= double.parse(currentUser!.glycPostMealT2) &&
        double.parse(value) < double.parse(currentUser!.glycPostMealT3)) {
      val = 2.5;
    }
    if (double.parse(value) >= double.parse(currentUser!.glycPostMealT3)) {
      val = 3.5;
    }
    return val;
  }

  getData(date) async {
    currentUser = await Tools().getCurrentUser();
    await Api().getLastValue(currentUser!.id, date).then((i) async {
      setState(() {
        if (i == "0") {
          lastValue = '-.-';
          value = 0;
        } else {
          lastValue = i;
          value = returnValuePin(i);
        }
      });
    });
    if (await SessionManager().containsKey("carnet")) {
      GlycemiqueLog carnet =
          GlycemiqueLog.fromJson(await SessionManager().get('carnet'));
      await Api().getLastHba1c(carnet.uid).then((value) async {
        setState(() {
          hba1c = double.parse(value);
        });
      });
    } else {
      setState(() => hba1c = 0);
    }
    setState(() {
      isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      String date = DateFormat("dd-MM-yyyy", "Fr_fr").format(DateTime.now());
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        await getData(date);
        dateTime = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: !isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.h),
                  child: Text(
                    'Suivez votre situation de prés en un coup d\'oeil,',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'CairoSemiBold',
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                5.verticalSpace,
                GestureDetector(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: const GlucoseStats(),
                      pageTransitionAnimation:
                          PageTransitionAnimation.slideRight,
                      withNavBar: false,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Container(
                      height: 215.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1.4.w),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 10.h),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.drop_fill,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text(
                                  'Dernière valeur Glucose',
                                  style: TextStyle(
                                    fontFamily: 'CairoSemiBold',
                                    fontSize: 14.sp,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  DateFormat("dd-MM-yyyy", "Fr_fr")
                                      .format(DateTime.now()),
                                  style: TextStyle(
                                    fontFamily: 'CairoSemiBold',
                                    fontSize: 14.sp,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: SizedBox(
                              height: 160.h,
                              child: SfRadialGauge(
                                axes: <RadialAxis>[
                                  RadialAxis(
                                    showLabels: false,
                                    showAxisLine: false,
                                    showTicks: false,
                                    minimum: 0,
                                    maximum: 4,
                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                        label: "Hypo",
                                        labelStyle: GaugeTextStyle(
                                          fontFamily: "CairoBold",
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                        ),
                                        startValue: 0,
                                        endValue: 1,
                                        color: const Color.fromRGBO(
                                            235, 35, 46, 1),
                                        sizeUnit: GaugeSizeUnit.factor,
                                        startWidth: 0.30,
                                        endWidth: 0.30,
                                      ),
                                      GaugeRange(
                                        label: "Ok",
                                        labelStyle: GaugeTextStyle(
                                          fontFamily: "CairoBold",
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                        ),
                                        startValue: 1,
                                        endValue: 2,
                                        color: const Color.fromRGBO(
                                            111, 193, 34, 1),
                                        sizeUnit: GaugeSizeUnit.factor,
                                        startWidth: 0.30,
                                        endWidth: 0.30,
                                      ),
                                      GaugeRange(
                                        label: "Elevé",
                                        labelStyle: GaugeTextStyle(
                                          fontFamily: "CairoBold",
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                        ),
                                        startValue: 2,
                                        endValue: 3,
                                        color: const Color.fromRGBO(
                                            251, 187, 43, 1),
                                        sizeUnit: GaugeSizeUnit.factor,
                                        startWidth: 0.30,
                                        endWidth: 0.30,
                                      ),
                                      GaugeRange(
                                        label: "Hyper",
                                        labelStyle: GaugeTextStyle(
                                          fontFamily: "CairoBold",
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                        ),
                                        startValue: 3,
                                        endValue: 4,
                                        color:
                                            const Color.fromRGBO(248, 99, 0, 1),
                                        sizeUnit: GaugeSizeUnit.factor,
                                        startWidth: 0.30,
                                        endWidth: 0.30,
                                      ),
                                    ],
                                    pointers: value != 0
                                        ? <GaugePointer>[
                                            NeedlePointer(
                                              value: double.parse(
                                                  value.toString()),
                                              lengthUnit: GaugeSizeUnit.factor,
                                            )
                                          ]
                                        : <GaugePointer>[],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                        widget: Text(
                                          lastValue! + '\n g/l ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'CairoSemiBold',
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                              height: 1.2),
                                        ),
                                        angle: 90,
                                        positionFactor: 0.8,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                10.verticalSpace,
                GestureDetector(
                  onTap: () async {
                    bool isTrue = await SessionManager().containsKey("hba1c");
                    if (isTrue) {
                      pushNewScreen(
                        context,
                        screen: const HBA1CResultat(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideRight,
                        withNavBar: false,
                      );
                    } else {
                      pushNewScreen(
                        context,
                        screen: const HBA1CFirstScreen(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideRight,
                        withNavBar: false,
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: Container(
                      height: 215.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1.4.w),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 10.h),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Boxicons.bxs_archive_out,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text(
                                  'HBA1C estimé',
                                  style: TextStyle(
                                    fontFamily: 'CairoRegular',
                                    fontSize: 14.sp,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            const Spacer(),
                            Center(
                              child: SizedBox(
                                height: 145.h,
                                child: SfRadialGauge(
                                  axes: <RadialAxis>[
                                    RadialAxis(
                                      showLabels: false,
                                      showAxisLine: false,
                                      showTicks: false,
                                      minimum: 0,
                                      maximum:
                                          double.parse(currentUser!.hba1c) * 2,
                                      ranges: <GaugeRange>[
                                        GaugeRange(
                                          startValue: 0,
                                          endValue:
                                              double.parse(currentUser!.hba1c),
                                          color: const Color.fromRGBO(
                                              111, 193, 34, 1),
                                          sizeUnit: GaugeSizeUnit.factor,
                                          startWidth: 0.30,
                                          endWidth: 0.30,
                                        ),
                                        GaugeRange(
                                          startValue:
                                              double.parse(currentUser!.hba1c),
                                          endValue:
                                              double.parse(currentUser!.hba1c) *
                                                  2,
                                          color: const Color.fromRGBO(
                                              251, 187, 43, 1),
                                          sizeUnit: GaugeSizeUnit.factor,
                                          startWidth: 0.30,
                                          endWidth: 0.30,
                                        ),
                                      ],
                                      pointers: hba1c != 0
                                          ? <GaugePointer>[
                                              NeedlePointer(
                                                value: double.parse(
                                                    hba1c.toString()),
                                                lengthUnit:
                                                    GaugeSizeUnit.factor,
                                              )
                                            ]
                                          : <GaugePointer>[],
                                      annotations: <GaugeAnnotation>[
                                        GaugeAnnotation(
                                          widget: Text(
                                            hba1c == 0
                                                ? '-.-'
                                                : hba1c!.toStringAsFixed(2) +
                                                    "%",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'CairoSemiBold',
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                                          angle: 90,
                                          positionFactor: 0.8,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/Tools.dart';
import 'package:glucotel/model/user.dart';
import 'package:intl/intl.dart';
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

  setTomorrowDate() async {
    String dateTime = await SessionManager().get('tomorrow');
    DateTime tomorrow = DateTime.parse(dateTime).add(const Duration(hours: 1));
    await SessionManager().set('tomorrow', tomorrow.toString());
  }

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

  double? val;
  getData(date) async {
    await Tools().getCurrentUser().then((value) async {
      setState(() {
        currentUser = value;
      });
      /* await MySql().getLastValue(currentUser!.id, date).then((value) {
        setState(() {
          if (value == "0") {
            lastValue = '-.-';
            val = 0;
          } else {
            lastValue = value;
            val = returnValuePin(lastValue);
          }
          isLoading = true;
        });
      }); */
    });
  }

  String lastValue = '-.-';
  int stps = 0;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      String date = DateFormat("yyyy-MM-dd", "Fr_fr").format(DateTime.now());
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
                      fontFamily: 'NunitoSemiBold',
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                GestureDetector(
                  onTap: () {
                    /* pushNewScreen(
                      context,
                      screen: const GlucoseStats(),
                      pageTransitionAnimation:
                          PageTransitionAnimation.slideRight,
                      withNavBar: false,
                    ); */
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0.w),
                    height: 215.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1.4.w),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.0.w),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.drop_fill,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                'Dernière valeur Glucose',
                                style: TextStyle(
                                  fontFamily: 'NunitoRegular',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                DateFormat("dd MMM yyyy", "Fr_fr")
                                    .format(dateTime),
                                style: TextStyle(
                                  fontFamily: 'NunitoSemiBold',
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                            ],
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
                                          fontFamily: "NunitoBold",
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
                                          fontFamily: "NunitoBold",
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
                                          fontFamily: "NunitoBold",
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
                                          fontFamily: "NunitoBold",
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
                                    pointers: val != 0
                                        ? <GaugePointer>[
                                            NeedlePointer(
                                              value:
                                                  double.parse(val.toString()),
                                              lengthUnit: GaugeSizeUnit.factor,
                                            )
                                          ]
                                        : <GaugePointer>[],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                        widget: Text(
                                          lastValue + '\n g/l ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'NunitoSemiBold',
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
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
    );
  }
}

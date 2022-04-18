// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:glucotel/Functions/Tools.dart';
import 'package:glucotel/functions/notification.dart';
import 'package:glucotel/model/WaterReminder.dart';
import 'package:glucotel/views/RemindersScreen/water_reminder_resultat.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';

class WaterReminderScreen extends StatefulWidget {
  const WaterReminderScreen({Key? key}) : super(key: key);

  @override
  State<WaterReminderScreen> createState() => _WaterReminderScreenState();
}

class _WaterReminderScreenState extends State<WaterReminderScreen> {
  double dailyQte = 0;

  int weight = 50;
  DateTime wakeUpTime = DateTime.now();
  DateTime bedTime = DateTime.now();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Tools().getCurrentUser().then((value) async {
      setState(() {
        weight = int.parse(value!.weight);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/water.png',
                      height: 100.h,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: Text(
                      'Salut,',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 22.sp,
                        fontFamily: 'CairoSemiBold',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: Text(
                      "Je suis votre compagnon d'hydratation personnel.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 16.sp,
                        fontFamily: 'CairoSemiBold',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: Text(
                      "Afin de fournir des conseils d'hydratation sur mesure, j'ai besoin d'obtenir quelques informations de base. Et je garderai ça secret.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 16.sp,
                        fontFamily: 'CairoSemiBold',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      Column(
        children: [
          SizedBox(
            height: 25.h,
          ),
          Text(
            'Votre poids',
            style: TextStyle(
              fontFamily: "CairoSemiBold",
              fontSize: 18.sp,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                width: 25.w,
              ),
              Image.asset(
                'assets/images/weight.jpeg',
                height: 350.h,
              ),
              SizedBox(
                width: 25.w,
              ),
              NumberPicker(
                value: weight,
                minValue: 0,
                maxValue: 100,
                textStyle: TextStyle(
                  fontFamily: "CairoRegular",
                  fontSize: 24.sp,
                  color: Theme.of(context).primaryColorDark.withAlpha(60),
                ),
                selectedTextStyle: TextStyle(
                  fontFamily: "CairoSemiBold",
                  fontSize: 24.sp,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: (value) => setState(() => weight = value),
              ),
              SizedBox(
                width: 35.w,
              ),
              Text(
                'Kg',
                style: TextStyle(
                  fontFamily: "CairoSemiBold",
                  fontSize: 26.sp,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
        ],
      ),
      Column(
        children: [
          SizedBox(
            height: 25.h,
          ),
          Text(
            'Heure de réveil',
            style: TextStyle(
              fontFamily: "CairoSemiBold",
              fontSize: 18.sp,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                width: 25.w,
              ),
              Image.asset(
                'assets/images/wakeup.jpeg',
                height: 280.h,
              ),
              SizedBox(
                width: 25.w,
              ),
              TimePickerSpinner(
                is24HourMode: true,
                time: wakeUpTime,
                normalTextStyle: TextStyle(
                  fontFamily: "CairoRegular",
                  fontSize: 24.sp,
                  color: Theme.of(context).primaryColorDark.withAlpha(60),
                ),
                highlightedTextStyle: TextStyle(
                  fontFamily: "CairoSemiBold",
                  fontSize: 24.sp,
                  color: Theme.of(context).primaryColor,
                ),
                spacing: 50,
                itemHeight: 80,
                isForce2Digits: true,
                onTimeChange: (time) {
                  setState(() {
                    wakeUpTime = time;
                  });
                },
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
        ],
      ),
      Column(
        children: [
          SizedBox(
            height: 25.h,
          ),
          Text(
            'Heure du coucher',
            style: TextStyle(
              fontFamily: "CairoSemiBold",
              fontSize: 18.sp,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                width: 25.w,
              ),
              Image.asset(
                'assets/images/bedtime.jpg',
                height: 350.h,
              ),
              SizedBox(
                width: 25.w,
              ),
              TimePickerSpinner(
                is24HourMode: true,
                time: bedTime,
                normalTextStyle: TextStyle(
                  fontFamily: "CairoRegular",
                  fontSize: 24.sp,
                  color: Theme.of(context).primaryColorDark.withAlpha(60),
                ),
                highlightedTextStyle: TextStyle(
                  fontFamily: "CairoSemiBold",
                  fontSize: 24.sp,
                  color: Theme.of(context).primaryColor,
                ),
                spacing: 50,
                itemHeight: 80,
                isForce2Digits: true,
                onTimeChange: (time) {
                  setState(() {
                    bedTime = time;
                  });
                },
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
        ],
      ),
    ];
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
                Boxicons.bxs_arrow_to_left,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (i, index) {
                  return _list[currentIndex];
                },
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  4,
                  (index) => buildDot(index, context),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Row(
                children: [
                  currentIndex != 0
                      ? Center(
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                if (currentIndex != 0) {
                                  currentIndex--;
                                }
                              });
                            },
                            child: Container(
                              height: 55.h,
                              width: 55.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Boxicons.bxs_chevron_left,
                                size: 25.w,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  const Spacer(),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        if (currentIndex != _list.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        } else if (currentIndex == _list.length - 1) {
                          if (await SessionManager()
                              .containsKey('waterReminder')) {
                            WaterReminder wt = WaterReminder.fromJson(
                                await SessionManager().get('waterReminder'));
                            int uid = wt.uid;
                            for (var i = 0; i < 9; i++) {
                              NotificationService().cancelNotification(uid + i);
                            }
                            dailyQte = weight - 20;
                            dailyQte = dailyQte * 15;
                            dailyQte = dailyQte + 1500;
                            DateTime dateone =
                                wakeUpTime.add(const Duration(days: 1));
                            DateTime datetwo =
                                bedTime.add(const Duration(days: 1));
                            if (datetwo.hour == 0 ||
                                datetwo.hour < dateone.hour) {
                              datetwo = DateTime(
                                  datetwo.year,
                                  datetwo.month,
                                  datetwo.day + 1,
                                  datetwo.hour,
                                  datetwo.minute);
                            }
                            uid = DateTime.now().microsecond;
                            for (var i = 0; i < 9; i++) {
                              NotificationService().scheduleNotification(
                                uid + i,
                                dateone,
                                "Rappel de l'eau",
                                "Il est temps de boire de l'eau.",
                                "water",
                                everyDay: true,
                              );
                              dateone = dateone.add(const Duration(hours: 2));
                            }
                            WaterReminder waterReminder = WaterReminder(
                              status: true,
                              dailyQte: dailyQte,
                              notification: true,
                              uid: uid,
                              daily: true,
                              date: DateFormat.yMd().format(dateone).toString(),
                              intake: "0",
                              isToday: false,
                            );
                            await SessionManager()
                                .set('waterReminder', waterReminder);
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child: const WaterBoarding(),
                                type: PageTransitionType.leftToRight,
                              ),
                            );
                          } else {
                            dailyQte = weight - 20;
                            dailyQte = dailyQte * 15;
                            dailyQte = dailyQte + 1500;
                            DateTime dateone =
                                wakeUpTime.add(const Duration(days: 1));
                            DateTime datetwo =
                                bedTime.add(const Duration(days: 1));
                            if (datetwo.hour == 0 ||
                                datetwo.hour < dateone.hour) {
                              datetwo = DateTime(
                                  datetwo.year,
                                  datetwo.month,
                                  datetwo.day + 1,
                                  datetwo.hour,
                                  datetwo.minute);
                            }
                            int uid = DateTime.now().microsecond;
                            for (var i = 0; i < 9; i++) {
                              NotificationService().scheduleNotification(
                                uid + i,
                                dateone,
                                "Rappel de l'eau",
                                "Il est temps de boire de l'eau.",
                                'water',
                                everyDay: true,
                              );
                              dateone = dateone.add(const Duration(hours: 2));
                            }
                            WaterReminder waterReminder = WaterReminder(
                              status: true,
                              dailyQte: dailyQte,
                              notification: true,
                              uid: uid,
                              daily: true,
                              date: DateFormat.yMd().format(dateone).toString(),
                              intake: "0",
                              isToday: false,
                            );
                            await SessionManager()
                                .set('waterReminder', waterReminder);
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child: const WaterBoarding(),
                                type: PageTransitionType.leftToRight,
                              ),
                            );
                          }
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
                          currentIndex != 0 ? 'Suivant' : "Démarrer",
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
            SizedBox(
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.h,
      width: currentIndex == index ? 40.w : 15.w,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.3),
      ),
    );
  }
}

class WaterBoarding extends StatefulWidget {
  const WaterBoarding({Key? key}) : super(key: key);

  @override
  State<WaterBoarding> createState() => _WaterBoardingState();
}

class _WaterBoardingState extends State<WaterBoarding> {
  double? dailyQte;
  getData() async {
    WaterReminder waterReminder =
        WaterReminder.fromJson(await SessionManager().get("waterReminder"));
    setState(() {
      dailyQte = waterReminder.dailyQte;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
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
        body: Column(
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: Text(
                "La quantité d'eau optimale que vous dévez boire tous les jours est :\n" +
                    dailyQte!.toStringAsFixed(0) +
                    "ml",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "CairoSemiBold",
                  fontSize: 16.sp,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            const Spacer(),
            Image.asset(
              'assets/images/cup.png',
              height: 75.h,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: Text(
                "Ne vous inquiétez pas, vous serez notifiés tout au long de la journée pour atteindre votre objectif",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "CairoSemiBold",
                  fontSize: 16.sp,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: Text(
                "Ce rappel sera activé à partir de demain",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "CairoSemiBold",
                  fontSize: 16.sp,
                  color: Colors.red,
                ),
              ),
            ),
            const Spacer(),
            Image.asset(
              'assets/images/cuo_2.png',
              height: 105.h,
            ),
            const Spacer(),
            Center(
              child: InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const WaterReminderResultat(),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
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
                    "Commencez",
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
              height: 80.h,
            ),
          ],
        ),
      ),
    );
  }
}

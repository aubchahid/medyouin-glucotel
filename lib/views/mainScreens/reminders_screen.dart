import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucotel/model/WaterReminder.dart';
import 'package:glucotel/views/RemindersScreen/mds_screen.dart';
import 'package:glucotel/views/RemindersScreen/rdv_screen.dart';
import 'package:glucotel/views/RemindersScreen/water_reminder.dart';
import 'package:glucotel/views/RemindersScreen/water_reminder_resultat.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class RemindersScreens extends StatefulWidget {
  const RemindersScreens({Key? key}) : super(key: key);

  @override
  State<RemindersScreens> createState() => _RemindersScreensState();
}

class _RemindersScreensState extends State<RemindersScreens> {
  DateTime thisDate = DateTime.now();
  late int days;
  bool status = false;
  WaterReminder? waterReminder;
  Future<bool> getData() async {
    bool st = await SessionManager().containsKey("waterReminder");
    WaterReminder? wt;
    if (st) {
      wt = WaterReminder.fromJson(await SessionManager().get('waterReminder'));
      st = wt.status;
    }

    return st;
  }

  Future<WaterReminder> getReminder() async {
    WaterReminder w =
        WaterReminder.fromJson(await SessionManager().get('waterReminder'));
    return w;
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        status = value;
      });
      if (status) {
        getReminder().then((value) {
          waterReminder = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Text(
              'Rappels',
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'CairoSemiBold',
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 215.h,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2.5.w),
              ),
              child: InkWell(
                onTap: () {
                  if (status) {
                    pushNewScreen(
                      context,
                      screen: const WaterReminderResultat(),
                      pageTransitionAnimation:
                          PageTransitionAnimation.slideRight,
                      withNavBar: false,
                    );
                  } else {
                    pushNewScreen(
                      context,
                      screen: const WaterReminderScreen(),
                      pageTransitionAnimation:
                          PageTransitionAnimation.slideRight,
                      withNavBar: false,
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Rappel pour boire de l\'eau',
                            style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 14.sp,
                              fontFamily: 'CairoRegular',
                            ),
                          ),
                          const Spacer(),
                          Text(
                            status ? 'Actif' : 'Inactif',
                            style: TextStyle(
                              color: status ? Colors.green : Colors.red,
                              fontSize: 14.sp,
                              fontFamily: 'CairoRegular',
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            FontAwesomeIcons.solidCircleDot,
                            color: status ? Colors.green : Colors.red,
                            size: 20.w,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/water.png',
                              height: 120.h,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          15.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: const MedsScreen(),
                      pageTransitionAnimation:
                          PageTransitionAnimation.slideRight,
                      withNavBar: false,
                    );
                  },
                  child: Container(
                    height: 200.h,
                    width: (MediaQuery.of(context).size.width / 2) - 25.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 2.5.w),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/meds.png',
                          height: 120.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Medicaments',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'CairoRegular',
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: const RdvScreen(),
                      pageTransitionAnimation:
                          PageTransitionAnimation.slideRight,
                      withNavBar: false,
                    );
                  },
                  child: Container(
                    height: 200.h,
                    width: (MediaQuery.of(context).size.width / 2) - 25.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 2.5.w),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/autre.png',
                          height: 120.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Rendez-vous',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'CairoRegular',
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: file_names, must_be_immutable

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/Notification.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/views/RemindersScreen/mds_screen.dart';
import 'package:glucotel/views/RemindersScreen/rdv_screen.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';

class DetailsReminder extends StatefulWidget {
  int id, from;
  DetailsReminder({required this.id, required this.from, Key? key})
      : super(key: key);

  @override
  State<DetailsReminder> createState() => _DetailsReminderState();
}

class _DetailsReminderState extends State<DetailsReminder> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _loading,
      color: Theme.of(context).primaryColorDark,
      progressIndicator: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
        strokeWidth: 6.0,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                if (widget.from == 0) {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const MedsScreen(),
                      type: PageTransitionType.leftToRight,
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const RdvScreen(),
                      type: PageTransitionType.leftToRight,
                    ),
                  );
                }
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/meds.png',
                      height: 125.h,
                    ),
                    Image.asset(
                      'assets/images/autre.png',
                      height: 125.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: Text(
                  'Supprimer Rappel',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: 'CairoSemiBold',
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                'Voulez-vous vraiment supprimer ce rappel ?',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'CairoSemiBold',
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              Text(
                'cette action est irréversible',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'CairoSemiBold',
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              SizedBox(
                height: 35.h,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      _loading = true;
                    });
                    await Tools().getCurrentUser().then((value) async {
                      await Api()
                          .deleteReminder(value!.id, widget.id.toString())
                          .then((value) async {
                        await NotificationService()
                            .cancelNotification(widget.id);

                        if (widget.from == 0) {
                          Tools().showAchievementView(
                              context,
                              "Supprimé avec succès.",
                              "L'alerte médicale a été supprimée avec succès.");
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: const MedsScreen(),
                              type: PageTransitionType.leftToRight,
                            ),
                          );
                        } else {
                          Tools().showAchievementView(
                              context,
                              "Supprimé avec succès.",
                              "Rendez-vous supprimé avec succès.");
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: const RdvScreen(),
                              type: PageTransitionType.leftToRight,
                            ),
                          );
                        }
                      });
                    });
                  },
                  child: Container(
                    height: 55.h,
                    width: 220.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Supprimer",
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
    );
  }
}

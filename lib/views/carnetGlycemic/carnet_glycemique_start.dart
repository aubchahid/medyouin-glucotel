// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/notification.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/GlycemiqueLog.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/carnetGlycemic/details_carnet_glycemique.dart';
import 'package:glucotel/views/mainScreens/main_screen.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';

class GlycemicLogFirst extends StatefulWidget {
  const GlycemicLogFirst({Key? key}) : super(key: key);

  @override
  State<GlycemicLogFirst> createState() => _GlycemicLogFirstState();
}

class _GlycemicLogFirstState extends State<GlycemicLogFirst> {
  DateTime selectedDate = DateTime.now();
  Color color = const Color.fromRGBO(104, 103, 106, 1);

  String dateD = 'Choisissez la date';
  _selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 30),
    );
    setState(() {
      try {
        dateD = DateFormat('dd-MM-yyyy').format(date!).toString();
        selectedDate = date;
        color = Theme.of(context).primaryColorDark;
      } catch (e) {
        dateD = 'Choisissez la date';
      }
    });
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        isLoading: _isLoading,
        color: Theme.of(context).primaryColorDark,
        progressIndicator: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 6.0,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        ),
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: const MainScreen(index: 0),
                    type: PageTransitionType.rightToLeft,
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
          body: ListView(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
                child: Text(
                  'Carnet glycémique',
                  style: TextStyle(
                    fontFamily: 'CairoSemiBold',
                    fontSize: 18.sp,
                    height: 1.3,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: Image.asset(
                  'assets/images/picture.png',
                  height: 280.h,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
                alignment: Alignment.center,
                child: Text(
                  'Date de début',
                  style: TextStyle(
                    fontFamily: 'CairoSemiBold',
                    fontSize: 14.sp,
                    height: 1.3,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
              15.verticalSpace,
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
              15.verticalSpace,
              Center(
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    String end = DateFormat('dd-MM-yyyy hh:mm:ss')
                        .format(DateTime(selectedDate.year, selectedDate.month,
                            selectedDate.day + 6))
                        .toString();
                    String startAt = DateFormat('dd-MM-yyyy')
                        .format(selectedDate)
                        .toString();
                    String endAt = DateFormat('dd-MM-yyyy')
                        .format(DateTime(selectedDate.year, selectedDate.month,
                            selectedDate.day + 6))
                        .toString();
                    User? currentUser = await Tools().getCurrentUser();
                    await Api()
                        .insertLog(currentUser!.id, startAt, endAt)
                        .then((value) async {
                      GlycemiqueLog log = GlycemiqueLog(
                        uid: int.parse(value),
                        startAt: startAt,
                        endAt: endAt,
                        status: false,
                        dateS: DateFormat('dd-MM-yyyy').format(selectedDate),
                      );
                      int uid = DateTime.now().microsecond + 151;
                      DateTime dt =
                          DateFormat('dd-MM-yyyy hh:mm:ss').parse(end);
                      dt = dt.add(const Duration(hours: 12));
                      NotificationService().scheduleNotification(
                          uid,
                          dt,
                          "Carnet glycémique",
                          "Vous pouvez voir votre hba1c estimé maintenant",
                          "hba1c");
                      await SessionManager().set("carnet", log);
                      Tools().showAchievementView(context, "Créé avec succès.",
                          "Votre carnet glycémie a été créé avec succès.");
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const GlycemiqueDetails(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    });
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
                      "Créer mon carnet glycémique",
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

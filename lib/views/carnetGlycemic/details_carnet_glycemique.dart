// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/model/GlycemiqueLog.dart';
import 'package:glucotel/model/Jour.dart';
import 'package:glucotel/views/carnetGlycemic/add_carnet_glycemique.dart';
import 'package:glucotel/views/carnetGlycemic/carnet_glycemique_start.dart';
import 'package:glucotel/views/mainScreens/main_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class GlycemiqueDetails extends StatefulWidget {
  const GlycemiqueDetails({Key? key}) : super(key: key);

  @override
  State<GlycemiqueDetails> createState() => _GlycemiqueDetailsState();
}

class _GlycemiqueDetailsState extends State<GlycemiqueDetails> {
  GlycemiqueLog? carnet;
  List<Jour>? entries;
  DateTime date = DateTime.now();
  String? carentDate;
  bool isAfter = false;
  getData() async {
    GlycemiqueLog log =
        GlycemiqueLog.fromJson(await SessionManager().get('carnet'));
    List<Jour> a = await Api().getDetails(log.uid);
    setState(() {
      carnet = log;
      entries = a;
      loading = false;
    });
    carentDate = log.endAt;
    String tmpDate = DateFormat("dd-MM-yyyy").format(date);
    date = DateFormat("dd-MM-yyyy").parse(carentDate!);
    DateTime dt = DateFormat("dd-MM-yyyy").parse(tmpDate);
    if (dt.isAfter(date)) {
      setState(() => isAfter = true);
    } else {
      setState(() => isAfter = false);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  bool returnValue = false;

  Future<void> newCarnetGly(BuildContext context, message) {
    // set up the button
    Widget cancelButton = TextButton(
      child: Text(
        "Non",
        style: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: () {
        returnValue = false;
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Oui",
        style: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: () async {
        await SessionManager().remove('carnet');
        /*   pushNewScreen(
          context,
          screen: const GlycemicLogFirst(),
          pageTransitionAnimation: PageTransitionAnimation.slideRight,
        ); */
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const GlycemicLogFirst()),
            ModalRoute.withName("/Home"));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
        child: Icon(
          Boxicons.bx_error_alt,
          color: Colors.red,
          size: 50.h,
        ),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'CairoBold',
          fontSize: 14.sp,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

    return Future.value(returnValue);
  }

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: InkWell(
                onTap: () async {
                  newCarnetGly(context,
                      "Êtes-vous sûr de vouloir créer un nouveau carnet glycémique ? votre actuel il sera supprimé");
                },
                child: Icon(
                  Boxicons.bx_refresh,
                  size: 35.h,
                ),
              ),
            ),
          ],
          elevation: 0,
        ),
        floatingActionButton: !isAfter
            ? InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const AddGlycemiqueValue(),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                },
                child: Container(
                  height: 55.h,
                  width: 220.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Ajouter une valuer',
                    style: TextStyle(
                      fontFamily: "CairoBold",
                      fontSize: 14.sp,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              )
            : Container(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: Text(
                      'Carnet Glycemique',
                      style: TextStyle(
                        fontFamily: "CairoBold",
                        fontSize: 18.sp,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          "Commencer à : " + carnet!.startAt,
                          style: TextStyle(
                            fontFamily: "CairoBold",
                            fontSize: 14.sp,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "-",
                          style: TextStyle(
                            fontFamily: "CairoBold",
                            fontSize: 14.sp,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Fin à : " + carnet!.endAt,
                          style: TextStyle(
                            fontFamily: "CairoBold",
                            fontSize: 14.sp,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  entries!.isEmpty
                      ? Column(
                          children: [
                            50.verticalSpace,
                            Center(
                              child:
                                  Image.asset('assets/images/emptyState.png'),
                            ),
                            20.verticalSpace,
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Text(
                                  'Commencez à ajouter des valeurs à votre carnet glycémique',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "CairoSemiBold",
                                    fontSize: 14.sp,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: entries!.length,
                            itemBuilder: (_, i) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: SizedBox(
                                  height: 180.h,
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                entries![i].date,
                                                style: TextStyle(
                                                  fontFamily: "CairoSemiBold",
                                                  fontSize: 14.sp,
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                'Faire défiler',
                                                style: TextStyle(
                                                  fontFamily: "CairoSemiBold",
                                                  fontSize: 14.sp,
                                                  color: Theme.of(context)
                                                      .primaryColorDark
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                              Icon(
                                                Boxicons.bxs_right_arrow_alt,
                                                color: Theme.of(context)
                                                    .primaryColorDark
                                                    .withOpacity(0.4),
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            height: 100.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  entries![i].values.length,
                                              itemBuilder: (_, j) {
                                                return SizedBox(
                                                  height: 100.h,
                                                  width: 120.h,
                                                  child: Card(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Spacer(),
                                                        Text(
                                                          entries![i].values[j]
                                                              ['text']!,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "CairoBold",
                                                            fontSize: 14.sp,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorDark,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          entries![i].values[j]
                                                                  ['value']! +
                                                              ' g/l',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "CairoBold",
                                                            fontSize: 14.sp,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorDark,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  60.verticalSpace,
                ],
              ),
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/model/GlycemiqueLog.dart';
import 'package:glucotel/model/Jour.dart';
import 'package:glucotel/views/carnetGlycemic/add_carnet_glycemique.dart';
import 'package:page_transition/page_transition.dart';

class GlycemiqueDetails extends StatefulWidget {
  const GlycemiqueDetails({Key? key}) : super(key: key);

  @override
  State<GlycemiqueDetails> createState() => _GlycemiqueDetailsState();
}

class _GlycemiqueDetailsState extends State<GlycemiqueDetails> {
  GlycemiqueLog? carnet;
  List<Jour>? entries;
  getData() async {
    GlycemiqueLog log =
        GlycemiqueLog.fromJson(await SessionManager().get('carnet'));
    List<Jour> a = await Api().getDetails(log.uid);
    setState(() {
      carnet = log;
      entries = a;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
        floatingActionButton: InkWell(
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
        ),
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
                  Expanded(
                    child: ListView.builder(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          Boxicons.bxs_arrow_to_right,
                                          color: Theme.of(context)
                                              .primaryColorDark
                                              .withOpacity(0.4),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      height: 100.h,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: entries![i].values.length,
                                        itemBuilder: (_, j) {
                                          return SizedBox(
                                            height: 100.h,
                                            width: 120.h,
                                            child: Card(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Spacer(),
                                                  Text(
                                                    entries![i].values[j]
                                                        ['text']!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "CairoBold",
                                                      fontSize: 14.sp,
                                                      color: Theme.of(context)
                                                          .primaryColorDark,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    entries![i].values[j]
                                                            ['value']! +
                                                        ' m/l',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "CairoBold",
                                                      fontSize: 14.sp,
                                                      color: Theme.of(context)
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
                  )
                ],
              ),
      ),
    );
  }
}

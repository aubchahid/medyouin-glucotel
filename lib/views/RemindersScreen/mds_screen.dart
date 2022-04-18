// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/Tools.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/model/Reminder.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/RemindersScreen/details_screen.dart';
import 'package:glucotel/views/RemindersScreen/new_mds.dart';
import 'package:page_transition/page_transition.dart';

class MedsScreen extends StatefulWidget {
  const MedsScreen({Key? key}) : super(key: key);

  @override
  State<MedsScreen> createState() => _MedsScreenState();
}

class _MedsScreenState extends State<MedsScreen> {
  bool _isLoading = false;
  User? currentUesr;
  List<Reminder> _reminder = [];

  getData() async {
    await Tools().getCurrentUser().then((value) async {
      setState(() {
        currentUesr = value;
      });
      await Api().selectReminder(value!.id).then((value) {
        try {
          setState(() {
            _reminder = value;
            _isLoading = true;
          });
        } catch (e) {
          setState(() {
            _isLoading = true;
          });
        }
      });
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
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.h),
              child: Row(
                children: [
                  Text(
                    'Rappel de médicaments',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'CairoSemiBold',
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const NewRappelScreen(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    child: Container(
                      width: 35.w,
                      height: 35.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1.4,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Boxicons.bx_plus,
                        size: 30.w,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            10.verticalSpace,
            _isLoading
                ? _reminder.isEmpty
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/meds.png',
                                height: 160.h,
                              ),
                            ),
                            Text(
                              'Commençons!',
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontFamily: 'CairoBold',
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.8),
                              ),
                            ),
                            10.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: Text(
                                'Recevez des rappels concernant vos médicaments et bien encore plus!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'CairoSemiBold',
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            70.verticalSpace,
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      child: const NewRappelScreen(),
                                      type: PageTransitionType.fade,
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
                                    "Ajouter un rappel",
                                    style: TextStyle(
                                      fontFamily: 'CairoBold',
                                      fontSize: 14.sp,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _reminder.length,
                          itemBuilder: (i, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    child: DetailsReminder(
                                      id: int.parse(_reminder[index].id),
                                      from: 0,
                                    ),
                                    type: PageTransitionType.leftToRight,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0.w, vertical: 10.h),
                                child: Container(
                                  height: 100.h,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 1.4,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10.h,
                                      ),
                                      Image.asset(
                                        'assets/images/meds.png',
                                        height: 50.h,
                                      ),
                                      SizedBox(
                                        width: 10.h,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Spacer(),
                                          Text(
                                            _reminder[index].text,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: 'CairoSemiBold',
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            height: 30.h,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              child: Text(
                                                _reminder[index].date +
                                                    '   ' +
                                                    _reminder[index].hour,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontFamily: 'CairoSemiBold',
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                      const Spacer(),
                                      Icon(
                                        Boxicons.bxs_chevron_right,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).backgroundColor),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

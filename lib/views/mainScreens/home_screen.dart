import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/Blog.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/carnetGlycemic/carnet_glycemique_start.dart';
import 'package:glucotel/views/carnetGlycemic/details_carnet_glycemique.dart';
import 'package:glucotel/widgets/BlogCardOneType.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? currentUser;
  bool _isloading = true;
  double? value;
  String? lastValue;
  List<Blog> blogs = [];

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
      await Api().getBlogs().then((value) {
        setState(() {
          blogs = value;
          _isloading = false;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      String date = DateFormat("dd-MM-yyyy", "Fr_fr").format(DateTime.now());
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        await getData(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).backgroundColor),
            ),
          )
        : ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Text(
                  'Bienvenue',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: 'CairoSemiBold',
                    color: Theme.of(context).primaryColorDark,
                    height: 1,
                  ),
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Text(
                  currentUser!.fullname,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: 'CairoSemiBold',
                    color: Theme.of(context).primaryColor,
                    height: 1,
                  ),
                ),
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Container(
                    height: 215.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 1.4.w),
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
                                      color:
                                          const Color.fromRGBO(235, 35, 46, 1),
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
                                      color:
                                          const Color.fromRGBO(111, 193, 34, 1),
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
                                      color:
                                          const Color.fromRGBO(251, 187, 43, 1),
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
                                            value:
                                                double.parse(value.toString()),
                                            lengthUnit: GaugeSizeUnit.factor,
                                          )
                                        ]
                                      : <GaugePointer>[],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Text(
                                        lastValue! + '\n gl/l ',
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
              15.verticalSpace,
              InkWell(
                onTap: () async {
                  bool isTrue = await SessionManager().containsKey("carnet");
                  if (isTrue) {
                    pushNewScreen(
                      context,
                      screen: const GlycemiqueDetails(),
                      pageTransitionAnimation:
                          PageTransitionAnimation.slideRight,
                      withNavBar: false,
                    );
                  } else {
                    Navigator.pop(context);
                    pushNewScreen(
                      context,
                      screen: const GlycemicLogFirst(),
                      pageTransitionAnimation:
                          PageTransitionAnimation.slideRight,
                      withNavBar: false,
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 65.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1.2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Mon carnet Glycemique',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'CairoSemiBold',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              15.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Text(
                  'Articles récents',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'CairoSemiBold',
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
              15.verticalSpace,
              CarouselSlider(
                options: CarouselOptions(
                  height: 100.h,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: false,
                ),
                items: blogs.map(
                  (blog) {
                    return Builder(
                      builder: (BuildContext context) {
                        return BlogCardTypeOne(
                          blog: blog,
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            ],
          );
  }
}

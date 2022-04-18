// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/model/Aliment.dart';

// ignore: must_be_immutable
class DetailsAliment extends StatefulWidget {
  Aliment aliment;
  DetailsAliment({required this.aliment, Key? key}) : super(key: key);

  @override
  State<DetailsAliment> createState() => _DetailsAlimentState();
}

class _DetailsAlimentState extends State<DetailsAliment> {
  Color getColor(i) {
    Color color = Colors.green;
    if (int.parse(i) < 40) {
      color = Colors.green;
    }
    if (int.parse(i) >= 40 && int.parse(i) < 60) {
      color = const Color.fromRGBO(219, 156, 1, 1);
    }
    if (int.parse(i) >= 60) {
      color = Colors.red;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Center(
                child: SizedBox(
                  height: 150.h,
                  width: 150.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(360),
                    child: Image.network(
                      'https://glucosql.medyouin.com/api-v2/pictures/aliments/' +
                          widget.aliment.image,
                      width: 65.h,
                      height: 65.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    widget.aliment.aliment,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "CairoBold",
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.2),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35.w, vertical: 5.h),
                      child: Column(
                        children: [
                          Text(
                            'Index Glycémique',
                            style: TextStyle(
                              fontFamily: "CairoSemiBold",
                              fontSize: 20.sp,
                              color: getColor(widget.aliment.indexGlycemique),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            widget.aliment.indexGlycemique,
                            style: TextStyle(
                              fontFamily: "CairoRegular",
                              fontSize: 18.sp,
                              color: getColor(widget.aliment.indexGlycemique),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    const Spacer(),
                    Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 95.h,
                              height: 95.h,
                              child: Column(
                                children: [
                                  const Spacer(),
                                  Text(
                                    'Glucides',
                                    style: TextStyle(
                                      fontFamily: "CairoSemiBold",
                                      fontSize: 20.sp,
                                      height: 1.4,
                                    ),
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    widget.aliment.glucides + ' g',
                                    style: TextStyle(
                                      fontFamily: "CairoRegular",
                                      fontSize: 18.sp,
                                      height: 1.4,
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        20.verticalSpace,
                        Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 95.h,
                              height: 95.h,
                              child: Column(
                                children: [
                                  const Spacer(),
                                  Text(
                                    'Calories',
                                    style: TextStyle(
                                      fontFamily: "CairoSemiBold",
                                      fontSize: 20.sp,
                                      height: 1.4,
                                    ),
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    widget.aliment.calories + " Kcal",
                                    style: TextStyle(
                                      fontFamily: "CairoRegular",
                                      fontSize: 18.sp,
                                      height: 1.4,
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 95.h,
                              height: 95.h,
                              child: Column(
                                children: [
                                  const Spacer(),
                                  Text(
                                    'Proteines',
                                    style: TextStyle(
                                      fontFamily: "CairoSemiBold",
                                      fontSize: 20.sp,
                                      height: 1.4,
                                    ),
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    widget.aliment.proteines + ' g',
                                    style: TextStyle(
                                      fontFamily: "CairoRegular",
                                      fontSize: 18.sp,
                                      height: 1.4,
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        20.verticalSpace,
                        Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.2),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 95.h,
                              height: 95.h,
                              child: Column(
                                children: [
                                  const Spacer(),
                                  Text(
                                    'Lipides',
                                    style: TextStyle(
                                      fontFamily: "CairoSemiBold",
                                      fontSize: 20.sp,
                                      height: 1.4,
                                    ),
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    widget.aliment.lipides + " g",
                                    style: TextStyle(
                                      fontFamily: "CairoRegular",
                                      fontSize: 18.sp,
                                      height: 1.4,
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

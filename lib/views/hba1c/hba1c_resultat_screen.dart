// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/GlycemiqueLog.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/carnetGlycemic/carnet_glycemique_start.dart';
import 'package:glucotel/views/carnetGlycemic/details_carnet_glycemique.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HBA1CResultat extends StatefulWidget {
  const HBA1CResultat({Key? key}) : super(key: key);

  @override
  State<HBA1CResultat> createState() => _HBA1CResultatState();
}

class _HBA1CResultatState extends State<HBA1CResultat> {
  DateTime date = DateTime.now();
  String? carentDate;
  bool isAfter = false;
  bool _isLoading = true, isConditon = false;
  double? hba1c;
  User? currentUser;

  getDate() async {
    currentUser = await Tools().getCurrentUser();
    DateTime? dt;
    if (await SessionManager().containsKey('carnet')) {
      GlycemiqueLog carnet =
          GlycemiqueLog.fromJson(await SessionManager().get('carnet'));
      carentDate = carnet.endAt;
      String tmpDate = DateFormat("dd-MM-yyyy").format(date);
      date = DateFormat("dd-MM-yyyy").parse(carentDate!);
      dt = DateFormat("dd-MM-yyyy").parse(tmpDate);
      if (dt.isAfter(date)) {
        await Api().checkCarnet(carnet.uid).then((value) async {
          if (value) {
            await Api().getHba1c(carnet.uid).then((value) async {
              setState(() {
                hba1c = value;
              });
            });
            setState(() => isConditon = value);
          } else {
            setState(() => isConditon = value);
          }
        });
        setState(() {
          isAfter = true;
          _isLoading = false;
        });
      } else {
        setState(() {
          isAfter = false;
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        isAfter = false;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDate();
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
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(
                    height: 35.h,
                  ),
                  Center(
                    child: Text(
                      "Outil d'estimation de l'HBA1C (eA1c)",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 18.sp,
                        fontFamily: 'CairoSemiBold',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  !isConditon
                      ? Center(
                          child: Image.asset(
                            'assets/images/onBoarding_3.png',
                            height: 220.h,
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            height: 220.h,
                            child: SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                  showLabels: false,
                                  showAxisLine: false,
                                  showTicks: false,
                                  minimum: 0,
                                  maximum: double.parse(currentUser!.hba1c) * 2,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                      startValue: 0,
                                      endValue:
                                          double.parse(currentUser!.hba1c),
                                      color:
                                          const Color.fromRGBO(111, 193, 34, 1),
                                      sizeUnit: GaugeSizeUnit.factor,
                                      startWidth: 0.30,
                                      endWidth: 0.30,
                                    ),
                                    GaugeRange(
                                      startValue:
                                          double.parse(currentUser!.hba1c),
                                      endValue:
                                          double.parse(currentUser!.hba1c) * 2,
                                      color:
                                          const Color.fromRGBO(251, 187, 43, 1),
                                      sizeUnit: GaugeSizeUnit.factor,
                                      startWidth: 0.30,
                                      endWidth: 0.30,
                                    ),
                                  ],
                                  pointers: hba1c != 0
                                      ? <GaugePointer>[
                                          NeedlePointer(
                                            value:
                                                double.parse(hba1c.toString()),
                                            lengthUnit: GaugeSizeUnit.factor,
                                          )
                                        ]
                                      : <GaugePointer>[],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Text(
                                        hba1c!.toStringAsFixed(2) + "%",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: 'CairoSemiBold',
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
                        ),
                  80.verticalSpace,
                  isAfter
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Center(
                            child: Text(
                              isConditon
                                  ? "Ce résultat est juste une estimation basée sur les données de glycémie que vous avez saisie.\n N.B: Ce calcul ne doit  pas être utilisé pour prendre des décisions ou faire des modifications thérapeutiques."
                                  : "Votre carnet glycémique ne respecte pas les conditions, il faut au moins 2 valeurs par jour pour avoir une bonne estimation.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 14.sp,
                                fontFamily: 'CairoSemiBold',
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Center(
                            child: Text(
                              "Remplissez votre carnet Glycemique pour avoir votre hba1c estimé, il faut au moins 2 valeurs par jour pour avoir une bonne estimation.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 18.sp,
                                fontFamily: 'CairoSemiBold',
                              ),
                            ),
                          ),
                        ),
                  40.verticalSpace,
                  InkWell(
                    onTap: () async {
                      bool isTrue =
                          await SessionManager().containsKey("carnet");
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
                ],
              ),
      ),
    );
  }
}

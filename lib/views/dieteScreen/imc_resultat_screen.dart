import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/widgets/IMCWidget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcResultatScreens extends StatefulWidget {
  final String size, weight;
  final double resultat;

  const ImcResultatScreens({
    Key? key,
    required this.resultat,
    required this.size,
    required this.weight,
  }) : super(key: key);

  @override
  _ImcResultatScreensScreensState createState() =>
      _ImcResultatScreensScreensState();
}

class _ImcResultatScreensScreensState extends State<ImcResultatScreens> {
  late double index;

  @override
  // ignore: must_call_super
  void initState() {
    super.initState();
    if (widget.resultat < 18.5) {
      index = 10;
      selectOne = true;
      selectTwo = false;
      selectThree = false;
      selectFour = false;
      selectFive = false;
    } else if (widget.resultat >= 18.5 && widget.resultat < 25) {
      index = 30;
      selectOne = false;
      selectTwo = true;
      selectThree = false;
      selectFour = false;
      selectFive = false;
    } else if (widget.resultat >= 25 && widget.resultat < 30) {
      index = 50;
      selectOne = false;
      selectTwo = false;
      selectThree = true;
      selectFour = false;
      selectFive = false;
    } else if (widget.resultat >= 30 && widget.resultat < 35) {
      index = 70;
      selectOne = false;
      selectTwo = false;
      selectThree = false;
      selectFour = true;
      selectFive = false;
    } else if (widget.resultat >= 35) {
      index = 90;
      selectOne = false;
      selectTwo = false;
      selectThree = false;
      selectFour = false;
      selectFive = true;
    }
  }

  bool selectOne = false,
      selectTwo = false,
      selectThree = false,
      selectFour = false,
      selectFive = false;

  changeEtat(etat) {
    if (etat == 1) {
      setState(() {
        if (selectOne) {
          setState(() {
            selectOne = false;
          });
        } else {
          setState(() {
            selectOne = true;
          });
        }
        selectTwo = false;
        selectThree = false;
        selectFour = false;
        selectFive = false;
      });
    }
    if (etat == 2) {
      setState(() {
        selectOne = false;
        if (selectTwo) {
          setState(() {
            selectTwo = false;
          });
        } else {
          setState(() {
            selectTwo = true;
          });
        }
        selectThree = false;
        selectFour = false;
        selectFive = false;
      });
    }
    if (etat == 3) {
      setState(() {
        selectOne = false;
        selectTwo = false;
        if (selectThree) {
          setState(() {
            selectThree = false;
          });
        } else {
          setState(() {
            selectThree = true;
          });
        }
        selectFour = false;
        selectFive = false;
      });
    }
    if (etat == 4) {
      setState(() {
        selectOne = false;
        selectTwo = false;
        selectThree = false;
        if (selectFour) {
          setState(() {
            selectFour = false;
          });
        } else {
          setState(() {
            selectFour = true;
          });
        }
        selectFive = false;
      });
    }
    if (etat == 5) {
      setState(() {
        selectOne = false;
        selectTwo = false;
        selectThree = false;
        selectFour = false;
        if (selectFive) {
          setState(() {
            selectFive = false;
          });
        } else {
          setState(() {
            selectFive = true;
          });
        }
      });
    }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Taille (cm) : " + widget.size,
                      style: TextStyle(
                        fontFamily: "CairoBold",
                        fontSize: 14.sp,
                        color: const Color.fromRGBO(30, 30, 30, 1),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Poids (kg) : " + widget.weight,
                      style: TextStyle(
                        fontFamily: "CairoBold",
                        fontSize: 14.sp,
                        color: const Color.fromRGBO(30, 30, 30, 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: SizedBox(
                  height: 170.h,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        showLabels: false,
                        showAxisLine: false,
                        showTicks: false,
                        minimum: 0,
                        maximum: 99,
                        ranges: <GaugeRange>[
                          GaugeRange(
                            startValue: 0,
                            endValue: 20,
                            color: const Color.fromRGBO(16, 222, 186, 1),
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.30,
                            endWidth: 0.30,
                          ),
                          GaugeRange(
                            startValue: 20,
                            endValue: 40,
                            color: const Color.fromRGBO(26, 197, 65, 1),
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.30,
                            endWidth: 0.30,
                          ),
                          GaugeRange(
                            startValue: 40,
                            endValue: 60,
                            color: const Color.fromRGBO(251, 188, 0, 1),
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.30,
                            endWidth: 0.30,
                          ),
                          GaugeRange(
                            startValue: 60,
                            endValue: 80,
                            color: const Color.fromRGBO(252, 147, 20, 1),
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.30,
                            endWidth: 0.30,
                          ),
                          GaugeRange(
                            startValue: 80,
                            endValue: 100,
                            color: const Color.fromRGBO(210, 28, 15, 1),
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.30,
                            endWidth: 0.30,
                          ),
                        ],
                        pointers: <GaugePointer>[NeedlePointer(value: index)],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            angle: 90,
                            positionFactor: 0.5,
                            widget: Text(
                              "Votre IMC\n" +
                                  widget.resultat.toStringAsFixed(1),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "CairoBold",
                                fontSize: 14.sp,
                                color: const Color.fromRGBO(30, 30, 30, 1),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  changeEtat(1);
                },
                child: IMCWidget(
                  color: const Color.fromRGBO(16, 222, 186, 1),
                  text: "< 18.5 Maigreur",
                  isSelected: selectOne,
                ),
              ),
              selectOne
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(16, 222, 186, 1)
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Il faut savoir que le calcul de l’indice de masse corporelle ne tient pas compte de la répartition des liquides. Par exemple en cas de rétention d’eau (du liquide s’infiltre dans les tissus), il arrive que l’on constate une prise de poids rapide. Or, il ne s’agit pas de kilos liés à un excès alimentaire mais d’une variation transitoire du poids.",
                          style: TextStyle(
                            fontFamily: "CairoRegular",
                            fontSize: 14.sp,
                            height: 1.4,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              GestureDetector(
                onTap: () {
                  changeEtat(2);
                },
                child: IMCWidget(
                  color: const Color.fromRGBO(26, 197, 65, 1),
                  text: "18.5 à 24.9  Corpulence normale",
                  isSelected: selectTwo,
                ),
              ),
              selectTwo
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(26, 197, 65, 1)
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Il faut savoir que le calcul de l’indice de masse corporelle ne tient pas compte de la répartition des liquides. Par exemple en cas de rétention d’eau (du liquide s’infiltre dans les tissus), il arrive que l’on constate une prise de poids rapide. Or, il ne s’agit pas de kilos liés à un excès alimentaire mais d’une variation transitoire du poids.",
                          style: TextStyle(
                            fontFamily: "CairoRegular",
                            fontSize: 14.sp,
                            height: 1.4,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              GestureDetector(
                onTap: () {
                  changeEtat(3);
                },
                child: IMCWidget(
                  color: const Color.fromRGBO(251, 188, 0, 1),
                  text: "25 à 29.9 Surpoids",
                  isSelected: selectThree,
                ),
              ),
              selectThree
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(251, 188, 0, 1)
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Il faut savoir que le calcul de l’indice de masse corporelle ne tient pas compte de la répartition des liquides. Par exemple en cas de rétention d’eau (du liquide s’infiltre dans les tissus), il arrive que l’on constate une prise de poids rapide. Or, il ne s’agit pas de kilos liés à un excès alimentaire mais d’une variation transitoire du poids.",
                          style: TextStyle(
                            fontFamily: "CairoRegular",
                            fontSize: 14.sp,
                            height: 1.4,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              GestureDetector(
                onTap: () {
                  changeEtat(4);
                },
                child: IMCWidget(
                  color: const Color.fromRGBO(252, 147, 20, 1),
                  text: "30 à 34.9  Obésité modérée",
                  isSelected: selectFour,
                ),
              ),
              selectFour
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(252, 147, 20, 1)
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Il faut savoir que le calcul de l’indice de masse corporelle ne tient pas compte de la répartition des liquides. Par exemple en cas de rétention d’eau (du liquide s’infiltre dans les tissus), il arrive que l’on constate une prise de poids rapide. Or, il ne s’agit pas de kilos liés à un excès alimentaire mais d’une variation transitoire du poids.",
                          style: TextStyle(
                            fontFamily: "CairoRegular",
                            fontSize: 14.sp,
                            height: 1.4,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              GestureDetector(
                onTap: () {
                  changeEtat(5);
                },
                child: IMCWidget(
                  color: const Color.fromRGBO(210, 28, 15, 1),
                  text: "> 35  Obésité sévère",
                  isSelected: selectFive,
                ),
              ),
              selectFive
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(210, 28, 15, 1)
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Il faut savoir que le calcul de l’indice de masse corporelle ne tient pas compte de la répartition des liquides. Par exemple en cas de rétention d’eau (du liquide s’infiltre dans les tissus), il arrive que l’on constate une prise de poids rapide. Or, il ne s’agit pas de kilos liés à un excès alimentaire mais d’une variation transitoire du poids.",
                          style: TextStyle(
                            fontFamily: "CairoRegular",
                            fontSize: 14.sp,
                            height: 1.8,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

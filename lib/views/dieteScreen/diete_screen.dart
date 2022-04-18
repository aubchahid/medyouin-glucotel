// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/model/Aliment.dart';
import 'package:glucotel/views/dieteScreen/details_aliments_screen.dart';
import 'package:page_transition/page_transition.dart';

class DieteScreen extends StatefulWidget {
  const DieteScreen({Key? key}) : super(key: key);

  @override
  State<DieteScreen> createState() => _DieteScreenState();
}

class _DieteScreenState extends State<DieteScreen> {
  List<Aliment> aliments = [];
  List<Aliment> filter = [];
  final TextEditingController _search = TextEditingController();
  bool loading = true;
  getData() async {
    await Api().getAliments().then((value) {
      setState(() {
        aliments = value;
        loading = false;
        filter.addAll(aliments);
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
        body: Column(
          children: [
            Container(
              height: 125.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  height: 65.h,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: TextCapitalization.words,
                    controller: _search,
                    onChanged: (String e) {
                      setState(() {
                        filter = aliments
                            .where((a) => a.aliment
                                .toLowerCase()
                                .contains(e.toLowerCase()))
                            .toList();
                      });
                    },
                    style: TextStyle(
                      fontFamily: "CairoSemiBold",
                      fontSize: 14.sp,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Boxicons.bx_search),
                      hintText: 'Recherche',
                      filled: true,
                      fillColor: const Color.fromRGBO(235, 235, 235, 1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            loading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: filter.length,
                      itemBuilder: (_, i) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: DetailsAliment(
                                  aliment: filter[i],
                                ),
                                type: PageTransitionType.leftToRight,
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: SizedBox(
                              height: 185.h,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 75.h,
                                        width: 75.h,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(360),
                                          child: Image.network(
                                            'https://glucosql.medyouin.com/api-v2/pictures/aliments/' +
                                                filter[i].image,
                                            width: 75.h,
                                            height: 75.h,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                    15.horizontalSpace,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Spacer(),
                                        SizedBox(
                                          width: 215.h,
                                          child: Text(
                                            filter[i].aliment,
                                            style: TextStyle(
                                              fontFamily: "CairoRegular",
                                              fontSize: 14.sp,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: 215.w,
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'Calories',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "CairoSemiBold",
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  Text(
                                                    filter[i].calories +
                                                        " Kcal",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "CairoRegular",
                                                      fontSize: 14.sp,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                  10.verticalSpace,
                                                  Text(
                                                    'Glucides',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "CairoSemiBold",
                                                      fontSize: 14.sp,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                  Text(
                                                    filter[i].glucides + ' g',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "CairoRegular",
                                                      fontSize: 14.sp,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                children: [
                                                  Text(
                                                    'Lipides',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "CairoSemiBold",
                                                      fontSize: 14.sp,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                  Text(
                                                    filter[i].lipides + " g",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "CairoRegular",
                                                      fontSize: 14.sp,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                  10.verticalSpace,
                                                  Text(
                                                    'Proteines',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "CairoSemiBold",
                                                      fontSize: 14.sp,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                  Text(
                                                    filter[i].proteines + ' g',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "CairoRegular",
                                                      fontSize: 14.sp,
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/views/auth/sign_in.dart';
import 'package:page_transition/page_transition.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Tools().showAlertDialogExit(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.verticalSpace,
              Center(
                child: Image.asset(
                  'assets/images/logo_color.png',
                  width: 220.w,
                ),
              ),
              80.verticalSpace,
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Column(
                      children: [
                        Center(
                          child: Image.asset(
                            contents[i].image,
                            width: MediaQuery.of(context).size.width,
                            height: 280.h,
                          ),
                        ),
                        40.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: Center(
                            child: Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "CairoBold",
                                fontSize: 16.sp,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        20.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                          child: Center(
                            child: SizedBox(
                              height: 65.h,
                              child: Text(
                                contents[i].description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "CairoRegular",
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColorDark,
                                  height: 1.4.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDot(index, context),
                ),
              ),
              20.verticalSpace,
              Center(
                child: InkWell(
                  onTap: () {
                    if (currentIndex == contents.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const SignInScreen(),
                        ),
                      );
                    }
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn,
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
                      currentIndex == contents.length - 1
                          ? "Commencer"
                          : "Suivant",
                      style: TextStyle(
                        fontFamily: 'CairoBold',
                        fontSize: 14.sp,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.h,
      width: currentIndex == index ? 60.w : 15.w,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.6),
      ),
    );
  }
}

class UnbordingContent {
  String image;
  String title;
  String description;

  UnbordingContent(
      {required this.image, required this.title, required this.description});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Profitez de conseils et informations utiles',
      image: 'assets/images/onBoarding_1.png',
      description:
          "Vous trouverez des rubriques speciales pour repondre a tous vos soucis durant le suivi"),
  UnbordingContent(
      title: 'Gérez votre statut glycémie',
      image: 'assets/images/onBoarding_2.png',
      description:
          "Enregistrez vos chiffres glycémiques en bénéficiant de plusieurs méthodes efficaces pour suivre votre situation avec Glucotel"),
  UnbordingContent(
      title: 'Restez en contact avec votre médecin',
      image: 'assets/images/onBoarding_3.png',
      description:
          "Vous pouvez planifier votre prochain rendez-vous a distance avec un seul clic"),
];

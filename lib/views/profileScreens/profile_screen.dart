import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/auth.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/mainScreens/main_screen.dart';
import 'package:glucotel/views/profileScreens/mes_objectifs_screen.dart';
import 'package:glucotel/views/profileScreens/modify_image_screen.dart';
import 'package:glucotel/views/profileScreens/modify_profile_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _loading = false;
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        await Tools().getCurrentUser().then((value) async {
          setState(() {
            currentUser = value;
          });
        });
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
              pushNewScreen(
                context,
                screen: const MainScreen(index: 0),
                pageTransitionAnimation: PageTransitionAnimation.slideRight,
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
                Boxicons.bxs_user,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
          elevation: 0,
        ),
        body: currentUser == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    40.verticalSpace,
                    Center(
                      child: SizedBox(
                        height: 120.h,
                        width: 120.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: Image.network(
                            !currentUser!.isGoogle
                                ? "https://glucosql.medyouin.com/api-v2/pictures/" +
                                    currentUser!.photoUrl
                                : currentUser!.photoUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          currentUser!.fullname.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'CairoBold',
                            fontSize: 16.sp,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        Text(
                          currentUser!.email.toLowerCase(),
                          style: TextStyle(
                            fontFamily: 'CairoSemiBold',
                            fontSize: 14.sp,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ],
                    ),
                    40.verticalSpace,
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const ModifyProfilScreen(),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                      child: Container(
                        height: 65.h,
                        width: 335.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 32,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            15.horizontalSpace,
                            const Icon(
                              Boxicons.bxs_user,
                            ),
                            15.horizontalSpace,
                            Text(
                              'Profile',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 16.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Boxicons.bx_chevron_right,
                            ),
                            15.horizontalSpace,
                          ],
                        ),
                      ),
                    ),
                    currentUser!.isGoogle
                        ? Container()
                        : Column(
                            children: [
                              20.verticalSpace,
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: const ModifyImageScreen(),
                                      type: PageTransitionType.rightToLeft,
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 65.h,
                                  width: 335.w,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 32,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      15.horizontalSpace,
                                      const Icon(
                                        Boxicons.bxs_image,
                                      ),
                                      15.horizontalSpace,
                                      Text(
                                        "Modifier l'image de profil",
                                        style: TextStyle(
                                          fontFamily: 'CairoSemiBold',
                                          fontSize: 16.sp,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Boxicons.bx_chevron_right,
                                      ),
                                      15.horizontalSpace,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                    /* 20.verticalSpace,
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const ModifyPasswordScreen(),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                      child: Container(
                        height: 65.h,
                        width: 335.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 32,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            15.horizontalSpace,
                            const Icon(
                              Boxicons.bxs_lock,
                            ),
                            15.horizontalSpace,
                            Text(
                              'Change votre mot de passe',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 16.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Boxicons.bx_chevron_right,
                            ),
                            15.horizontalSpace,
                          ],
                        ),
                      ),
                    ), */
                    20.verticalSpace,
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const MesObjectifsScreen(),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                      child: Container(
                        height: 65.h,
                        width: 335.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 32,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            15.horizontalSpace,
                            const Icon(
                              Boxicons.bxs_bullseye,
                            ),
                            15.horizontalSpace,
                            Text(
                              'Modifier mes objectifs',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 16.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Boxicons.bx_chevron_right,
                            ),
                            15.horizontalSpace,
                          ],
                        ),
                      ),
                    ),
                    120.verticalSpace,
                    InkWell(
                      onTap: () async {
                        await Auth().signOut(context);
                      },
                      child: Container(
                        height: 65.h,
                        width: 335.w,
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            15.horizontalSpace,
                            const Icon(
                              Boxicons.bx_log_out_circle,
                              color: Colors.red,
                            ),
                            15.horizontalSpace,
                            Text(
                              'Se déconnecter',
                              style: TextStyle(
                                fontFamily: 'CairoSemiBold',
                                fontSize: 16.sp,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

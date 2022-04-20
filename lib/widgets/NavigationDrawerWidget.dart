// ignore_for_file: file_names

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucotel/functions/auth.dart';
import 'package:glucotel/model/MedicalFolder.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/blogsScreens/blog_screen.dart';
import 'package:glucotel/views/carnetGlycemic/carnet_glycemique_start.dart';
import 'package:glucotel/views/carnetGlycemic/details_carnet_glycemique.dart';
import 'package:glucotel/views/dieteScreen/depense_energetic_calculatrice.dart';
import 'package:glucotel/views/dieteScreen/diete_calculatrice_screen.dart';
import 'package:glucotel/views/dieteScreen/diete_screen.dart';
import 'package:glucotel/views/mainScreens/main_screen.dart';
import 'package:glucotel/views/medicalFolder/display_folder_medical.dart';
import 'package:glucotel/views/medicalFolder/medical_folder_screnn.dart';
import 'package:glucotel/views/profileScreens/mes_objectifs_screen.dart';
import 'package:glucotel/views/profileScreens/profile_screen.dart';
import 'package:glucotel/views/profileScreens/upcomming.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({required this.currentUser, Key? key})
      : super(key: key);
  final User? currentUser;
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            buildHeader(
              urlImage: !widget.currentUser!.isGoogle
                  ? "https://glucosql.medyouin.com/api-v2/pictures/default.png"
                  : widget.currentUser!.photoUrl,
              name: widget.currentUser!.fullname,
              email: widget.currentUser!.email,
              onClicked: () {},
            ),
            Divider(
              color: Colors.white70,
              thickness: 2.h,
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: ListView(
                children: [
                  buildMenuItem(
                    text: 'Accueil',
                    icon: Boxicons.bxs_home,
                    onClicked: () {
                      Navigator.pop(context);
                      pushNewScreen(
                        context,
                        screen: const MainScreen(
                          index: 0,
                        ),
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideRight,
                      );
                    },
                  ),
                  2.verticalSpace,
                  buildMenuItem(
                    text: 'Profil',
                    icon: Boxicons.bxs_user,
                    onClicked: () {
                      Navigator.pop(context);
                      pushNewScreen(
                        context,
                        screen: const ProfileScreen(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideRight,
                      );
                    },
                  ),
                  2.verticalSpace,
                  buildMenuItem(
                    text: 'Mon Carnet Glycemique',
                    icon: Boxicons.bxs_book_content,
                    onClicked: () async {
                      bool isTrue =
                          await SessionManager().containsKey("carnet");
                      if (isTrue) {
                        Navigator.pop(context);
                        pushNewScreen(
                          context,
                          screen: const GlycemiqueDetails(),
                          pageTransitionAnimation:
                              PageTransitionAnimation.slideRight,
                        );
                      } else {
                        Navigator.pop(context);
                        pushNewScreen(
                          context,
                          screen: const GlycemicLogFirst(),
                          pageTransitionAnimation:
                              PageTransitionAnimation.slideRight,
                        );
                      }
                    },
                  ),
                  2.verticalSpace,
                  buildMenuItem(
                    text: 'Mes objectifs',
                    icon: Boxicons.bxs_bullseye,
                    onClicked: () {
                      Navigator.pop(context);
                      pushNewScreen(
                        context,
                        screen: const MesObjectifsScreen(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideRight,
                      );
                    },
                  ),
                  2.verticalSpace,
                  buildMenuItem(
                    text: 'Info Diete',
                    icon: Boxicons.bxs_news,
                    onClicked: () {
                      Navigator.pop(context);
                      pushNewScreen(
                        context,
                        screen: const BlogsScreen(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideRight,
                      );
                    },
                  ),
                  2.verticalSpace,
                  buildMenuItem(
                    text: 'Tableau des aliments',
                    icon: Boxicons.bxs_cookie,
                    onClicked: () {
                      Navigator.pop(context);
                      pushNewScreen(
                        context,
                        screen: const DieteScreen(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideRight,
                      );
                    },
                  ),
                  2.verticalSpace,
                  buildMenuItem(
                    text: 'IMC Calculatrice',
                    icon: Boxicons.bxs_calculator,
                    onClicked: () {
                      Navigator.pop(context);
                      pushNewScreen(
                        context,
                        screen: const DieteCalculatriceScreen(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideRight,
                      );
                    },
                  ),
                  2.verticalSpace,
                  buildMenuItem(
                    text: 'Dépense énergétique Calculatrice',
                    icon: FontAwesomeIcons.bolt,
                    onClicked: () {
                      Navigator.pop(context);
                      pushNewScreen(
                        context,
                        screen: const IndexGlycemiqueScreen(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideRight,
                      );
                    },
                  ),
                  2.verticalSpace,
                  buildMenuItem(
                      text: 'Mon Dossier Médical',
                      icon: FontAwesomeIcons.fileWaveform,
                      onClicked: () async {
                        bool isTrue =
                            await SessionManager().containsKey("medicalFolder");
                        if (isTrue) {
                          MedicalFolder medicalFolder = MedicalFolder.fromJson(
                            await SessionManager().get("medicalFolder"),
                          );
                          isTrue = medicalFolder.status;
                        }
                        Navigator.pop(context);
                        if (isTrue) {
                          pushNewScreen(
                            context,
                            screen: const DisplayFolderMedicalScreen(),
                            pageTransitionAnimation:
                                PageTransitionAnimation.slideRight,
                          );
                        } else {
                          pushNewScreen(
                            context,
                            screen: const MedicalFolderScreen(),
                            pageTransitionAnimation:
                                PageTransitionAnimation.slideRight,
                          );
                        }
                      }),
                  2.verticalSpace,
                  buildMenuItem(
                    text: 'Medicaments',
                    icon: FontAwesomeIcons.syringe,
                    onClicked: () {
                      Navigator.pop(context);
                      pushNewScreen(
                        context,
                        screen: const UpComingScreen(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideRight,
                      );
                    },
                  ),
                  2.verticalSpace,
                  Divider(
                    color: Colors.white70,
                    thickness: 2.h,
                  ),
                  2.verticalSpace,
                  buildMenuItem(
                    text: 'Teleconsultation',
                    icon: Boxicons.bx_headphone,
                    onClicked: () {
                      Navigator.pop(context);
                      pushNewScreen(
                        context,
                        screen: const UpComingScreen(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideRight,
                      );
                    },
                  ),
                  2.verticalSpace,
                  buildMenuItem(
                    text: 'Video et capsules',
                    icon: Boxicons.bxs_video,
                    onClicked: () {
                      Navigator.pop(context);
                      pushNewScreen(
                        context,
                        screen: const UpComingScreen(),
                        pageTransitionAnimation:
                            PageTransitionAnimation.slideRight,
                      );
                    },
                  ),
                  Divider(
                    color: Colors.white70,
                    thickness: 2.h,
                  ),
                  2.verticalSpace,
                  buildMenuItem(
                    text: 'Déconnecter',
                    icon: FontAwesomeIcons.arrowRightFromBracket,
                    onClicked: () {
                      Navigator.pop(context);
                      Auth().signOut(context);
                    },
                  ),
                  2.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(
            EdgeInsets.symmetric(vertical: 12.w),
          ),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              SizedBox(
                height: 90.h,
                width: 90.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: Image.network(
                    urlImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email.toLowerCase(),
                    style: TextStyle(
                      fontFamily: 'CairoSemiBold',
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return InkWell(
      onTap: onClicked,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          text,
          style: TextStyle(
            fontFamily: 'CairoBold',
            fontSize: 15.sp,
            color: Colors.white,
          ),
        ),
        hoverColor: hoverColor,
      ),
    );
  }
}

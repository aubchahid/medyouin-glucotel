import 'dart:convert';
import 'dart:io';

import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/profileScreens/profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';

class ModifyImageScreen extends StatefulWidget {
  const ModifyImageScreen({Key? key}) : super(key: key);

  @override
  State<ModifyImageScreen> createState() => _ModifyImageScreenState();
}

class _ModifyImageScreenState extends State<ModifyImageScreen> {
  bool _loading = true, _isLoading = false;
  User? currentUser;
  File? image;
  String? fileName;
  String? base64Image;

  Future uploadImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() {
        this.image = imageTemp;
        fileName = imageTemp.path.split('/').last;
        base64Image = base64Encode(imageTemp.readAsBytesSync());
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        await Tools().getCurrentUser().then((value) async {
          setState(() {
            currentUser = value;
            _loading = false;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      color: Theme.of(context).primaryColorDark,
      progressIndicator: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
        strokeWidth: 6.0,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: const ProfileScreen(),
                    type: PageTransitionType.leftToRight,
                  ),
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
              )
            ],
            elevation: 0,
          ),
          body: _loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 15.h),
                        child: Text(
                          "Modifier l'image de profil",
                          style: TextStyle(
                            fontFamily: 'CairoSemiBold',
                            fontSize: 18.sp,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      image != null
                          ? Container(
                              height: 220.w,
                              width: 220.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              height: 220.w,
                              width: 220.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  !currentUser!.isGoogle
                                      ? "https://glucosql.medyouin.com/api-v2/pictures/" +
                                          currentUser!.photoUrl
                                      : currentUser!.photoUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      20.verticalSpace,
                      Center(
                        child: InkWell(
                          onTap: () async {
                            uploadImage();
                          },
                          child: Container(
                            height: 55.h,
                            width: 220.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.4.w),
                            ),
                            child: Text(
                              "Modifier",
                              style: TextStyle(
                                fontFamily: 'CairoBold',
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      Center(
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await Api()
                                .uploadImage(
                                    fileName, base64Image, currentUser!)
                                .then((value) async {
                              if (value == "RECORD_UPDATED_SUCCESSFULLY") {
                                User user = User.fromJson(
                                    await SessionManager().get("currentUser"));
                                user.photoUrl = fileName!;
                                await SessionManager().set('currentUser', user);
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    child: const ProfileScreen(),
                                    type: PageTransitionType.leftToRight,
                                  ),
                                );
                                Tools().showAchievementView(
                                    context,
                                    'Modification réussie.',
                                    'Votre image de profil a été modifiée.');
                              }
                            });
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
                              "Terminer",
                              style: TextStyle(
                                fontFamily: 'CairoBold',
                                fontSize: 14.sp,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

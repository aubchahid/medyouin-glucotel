import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/widgets/text_field.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ModifyPasswordScreen extends StatefulWidget {
  const ModifyPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ModifyPasswordScreen> createState() => _ModifyPasswordScreenState();
}

class _ModifyPasswordScreenState extends State<ModifyPasswordScreen> {
  User? currentUser;
  bool _loading = false;

  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _oldPassword = TextEditingController();

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
    return LoadingOverlay(
      isLoading: _loading,
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
                  Boxicons.bxs_user,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  child: Text(
                    'Change votre mot de passe',
                    style: TextStyle(
                      fontFamily: 'CairoSemiBold',
                      fontSize: 18.sp,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
                10.verticalSpace,
                InputTextField(
                  hintText: "Entrez l'ancien mot de passe",
                  type: TextInputType.text,
                  controller: _oldPassword,
                  icon: Boxicons.bxs_lock,
                  isPassword: true,
                ),
                10.verticalSpace,
                InputTextField(
                  hintText: "Entrez un nouveau mot de passe",
                  type: TextInputType.emailAddress,
                  controller: _newPassword,
                  icon: Boxicons.bxs_lock,
                  isPassword: true,
                ),
                10.verticalSpace,
                InputTextField(
                  hintText: "Confirmer le nouveau mot de passe",
                  type: TextInputType.text,
                  controller: _confirmPassword,
                  icon: Boxicons.bxs_lock,
                  isPassword: true,
                ),
                20.verticalSpace,
                Center(
                  child: InkWell(
                    onTap: () async {},
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
                          color: Theme.of(context).scaffoldBackgroundColor,
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

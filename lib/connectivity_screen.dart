import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectivityScreen extends StatefulWidget {
  const ConnectivityScreen({Key? key}) : super(key: key);

  @override
  State<ConnectivityScreen> createState() => _ConnectivityScreenState();
}

class _ConnectivityScreenState extends State<ConnectivityScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 45.h,
            ),
            Center(
              child: Image.asset(
                'assets/images/logo_color.png',
                width: 150.w,
              ),
            ),
            SizedBox(
              height: 45.h,
            ),
            Center(
              child: Image.asset(
                'assets/images/error.png',
                height: 350.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "Il n'y a pas de connexion Internet ou il y a un problème avec notre serveur",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'CairoSemiBold',
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "vérifiez votre connexion puis fermez l'application et rouvrez-la à nouveau,ou attendez un peu de temps puis redémarrez l'application.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'CairoSemiBold',
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/SplashScreen.dart';
import 'package:glucotel/connectivity_screen.dart';
//import 'package:glucotel/SplashScreen.dart';
import 'package:glucotel/firebase_options.dart';
import 'package:glucotel/functions/notification.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/complete_profil_screen.dart';
import 'package:glucotel/views/mainScreens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().initNotification();
  bool isLoggedIn = await SessionManager().get("isLoggedIn") ?? false;
  bool status = await SessionManager().containsKey("currentUser");
  bool isOnline = await Tools().hasNetwork();

  Widget mainPage;
  if (isOnline) {
    if (status) {
      User? user = User.fromJson(await SessionManager().get("currentUser"));
      status = user.status;
    }
    isLoggedIn
        ? status
            ? mainPage = const MainScreen(index: 0)
            : mainPage = const CompleteProfileScreen()
        : mainPage = const SplashScreen();
  } else {
    mainPage = const ConnectivityScreen();
  }
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (BuildContext context) => MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fr', ''), //
          Locale('ar', ''), //
        ],
        home: mainPage,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: const Color.fromRGBO(8, 85, 191, 1),
              ),
          primaryColor: const Color.fromRGBO(8, 85, 191, 1),
          primaryColorDark: const Color.fromRGBO(48, 48, 48, 1),
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        ),
      ),
    ),
  );
}

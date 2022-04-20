import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/notification.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/user.dart' as appuser;
import 'package:glucotel/views/auth/sign_in.dart';
import 'package:glucotel/views/complete_profil_screen.dart';
import 'package:glucotel/views/mainScreens/main_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

  // * Function For Sign in using an email and password
  emailSignIn(_email, _password, context) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: _email.toString().toLowerCase(), password: _password);
      User? _user = authResult.user;
      assert(!_user!.isAnonymous);
      User? currentUser = _auth.currentUser;
      assert(_user!.uid == currentUser!.uid);
      Api().checkUser(_user!.uid).then((value) async {
        if (value == "ACCOUNT-INACTIVE") {
          await Api().getUserByEmail(_user.uid).then((value) async {
            await SessionManager().set("isLoggedIn", true);
            await SessionManager().set(
              "currentUser",
              appuser.User(
                id: _user.uid,
                fullname: value['fullname'],
                email: _email,
                photoUrl: value['photoUrl'],
                phoneNo: value['phoneNo'],
                status: false,
                isGoogle: false,
              ),
            );
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: const CompleteProfileScreen(),
                type: PageTransitionType.rightToLeft,
              ),
            );
          });
        }
        if (value == "ACCOUNT-ACTIVE") {
          await Api().getUserByEmail(_user.uid).then((value) async {
            await SessionManager().set("isLoggedIn", true);
            await SessionManager().set(
              "currentUser",
              appuser.User(
                id: _user.uid,
                fullname: value['fullname'],
                email: _user.email.toString(),
                photoUrl: value['photoUrl'],
                phoneNo: _user.phoneNumber ?? '-',
                sexe: value['sexe'],
                birthdate: value["birthdate"],
                city: value["city"],
                size: value["size"],
                weight: value["weight"],
                glycPostMealT1: value["glucoPostMealT1"],
                glycPostMealT2: value["glucoPostMealT2"],
                glycPostMealT3: value["glucoPostMealT3"],
                glycPreMealT1: value["glucoPreMealT1"],
                glycPreMealT2: value["glucoPreMealT2"],
                glycPreMealT3: value["glucoPreMealT3"],
                hba1c: value["hba1c"],
                stepsPerDay: value["stepsPerDay"],
                typeDiabet: value["typeDiabet"],
                status: true,
                isGoogle: false,
              ),
            );
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: const MainScreen(
                  index: 0,
                ),
                type: PageTransitionType.rightToLeft,
              ),
            );
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Tools().showDesachievementView(context, "Message d'erreur",
            "Il n'y a pas d'utilisateur avec cet e-mail, veuillez entrer l'e-mail correct.");
      } else if (e.code == 'wrong-password') {
        Tools().showDesachievementView(context, "Message d'erreur",
            "Votre mot de passe est incorrect, veuillez saisir le  mot de passe correct.");
      }
    }
  }

  // * Function For Sign up using an email and password
  Future<bool> emailSignUp(
      _fullname, _phoneNo, _email, _password, context) async {
    bool isValid = false;
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      User? _user = authResult.user;
      assert(!_user!.isAnonymous);
      User? currentUser = _auth.currentUser;
      assert(_user!.uid == currentUser!.uid);
      Api()
          .insertUser(_user!.uid, _fullname, _email, _phoneNo)
          .then((value) async {
        if (value == "RECORD_CREATED_SUCCESSFULLY") {
          isValid = true;
          await SessionManager().set('isLoggedIn', true);
          await SessionManager().set(
            'currentUser',
            appuser.User(
              id: _user.uid,
              fullname: _fullname,
              email: _email,
              photoUrl: 'default.png',
              phoneNo: _phoneNo,
              status: false,
              isGoogle: false,
            ),
          );
          Navigator.push(
            context,
            PageTransition(
              child: const CompleteProfileScreen(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'email-already-in-use') {
        Tools().showDesachievementView(context, "Message d'erreur",
            "Cet email est déjà utilisé, veuillez entrer un autre email.");
        isValid = false;
      }
    }
    return Future.value(isValid);
  }

  // * Function For using Google Account for sign in
  Future<bool> googleSignIn(context) async {
    bool isSuccess = false;
    try {
      GoogleSignInAccount? _googleAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await _googleAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      UserCredential authResult = await _auth.signInWithCredential(credential);
      User? _user = authResult.user;
      Api().checkUser(_user!.uid).then((value) async {
        if (value == "ACCOUNT-INACTIVE") {
          Api().getUserByEmail(_user.uid).then((value) async {
            await SessionManager().set("isLoggedIn", true);
            await SessionManager().set(
              "currentUser",
              appuser.User(
                id: _user.uid,
                fullname: value['fullname'],
                email: _user.email.toString(),
                photoUrl: _user.photoURL!,
                phoneNo: _user.phoneNumber ?? '-',
                status: false,
                isGoogle: true,
              ),
            );
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: const CompleteProfileScreen(),
                type: PageTransitionType.rightToLeft,
              ),
            );
          });
        }
        if (value == "ACCOUNT-ACTIVE") {
          Api().getUserByEmail(_user.uid).then((value) async {
            await SessionManager().set("isLoggedIn", true);
            await SessionManager().set(
              "currentUser",
              appuser.User(
                id: _user.uid,
                fullname: value['fullname'],
                email: _user.email.toString(),
                photoUrl: _user.photoURL!,
                phoneNo: _user.phoneNumber ?? '-',
                sexe: value['sexe'],
                birthdate: value["birthdate"],
                city: value["city"],
                size: value["size"],
                weight: value["weight"],
                glycPostMealT1: value["glucoPostMealT1"],
                glycPostMealT2: value["glucoPostMealT2"],
                glycPostMealT3: value["glucoPostMealT3"],
                glycPreMealT1: value["glucoPreMealT1"],
                glycPreMealT2: value["glucoPreMealT2"],
                glycPreMealT3: value["glucoPreMealT3"],
                hba1c: value["hba1c"],
                stepsPerDay: value["stepsPerDay"],
                typeDiabet: value["typeDiabet"],
                status: true,
                isGoogle: true,
              ),
            );
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: const MainScreen(
                  index: 0,
                ),
                type: PageTransitionType.rightToLeft,
              ),
            );
          });
        }
        if (value == "USER-NOT-FOUND") {
          Api()
              .insertUser(_user.uid, _user.displayName, _user.email, '00000000')
              .then(
            (value) async {
              if (value == "RECORD_CREATED_SUCCESSFULLY") {
                await SessionManager().set("isLoggedIn", true);
                await SessionManager().set(
                  "currentUser",
                  appuser.User(
                    id: _user.uid,
                    fullname: _user.displayName.toString(),
                    email: _user.email.toString(),
                    photoUrl: _user.photoURL!,
                    phoneNo: _user.phoneNumber ?? '-',
                    status: false,
                    isGoogle: true,
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: const CompleteProfileScreen(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              }
            },
          );
        }
      });
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      isSuccess = false;
      debugPrint(e.toString());
    } catch (e) {
      isSuccess = false;
      debugPrint(e.toString());
    }
    return isSuccess;
  }

  // * Function For Sign out
  Future<Future> signOut(context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Confirmation",
          style: TextStyle(
            fontFamily: "CairoBold",
            fontSize: 14.sp,
            color: Theme.of(context).primaryColor,
          ),
        ),
        content: Text(
          "Êtes-vous certain de vouloir vous déconnecter?",
          style: TextStyle(
            fontFamily: "CairoBold",
            fontSize: 14.sp,
            color: const Color.fromRGBO(48, 49, 52, 1),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Non",
              style: TextStyle(
                fontFamily: "CairoBold",
                fontSize: 14.sp,
                color: Theme.of(context).primaryColorDark.withOpacity(0.6),
              ),
            ),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            child: Text(
              "Oui",
              style: TextStyle(
                fontFamily: "CairoBold",
                fontSize: 14.sp,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              _auth.signOut();
              _googleSignIn.signOut();
              SessionManager().destroy();
              NotificationService().cancelAllNotifications();
              await SessionManager().remove("currentUser");
              await SessionManager().remove("isLoggedIn");
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: const SignInScreen(),
                  type: PageTransitionType.fade,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

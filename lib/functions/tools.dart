import 'package:achievement_view/achievement_view.dart';
import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/model/ListItem.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/mainScreens/main_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';

class Tools {
  Future<bool> loginFormValidator(String _email, String _passowrd, context) {
    bool isValid = true;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
    if (_email.isEmpty) {
      //showAlertDialog(context, "Vous oubliez d'entrer votre adresse e-mail");
      showDesachievementView(context, "Message d'erreur",
          "Vous oubliez d'entrer votre adresse e-mail");
      isValid = false;
    } else if (!emailValid) {
      showDesachievementView(context, "Message d'erreur",
          "Il semble que vous n'ayez pas entré un e-mail correct");
      isValid = false;
    } else if (_passowrd.isEmpty) {
      showDesachievementView(context, "Message d'erreur",
          "Vous avez oublié d'entrer votre mot de passe");
      isValid = false;
    }
    return Future.value(isValid);
  }

  Future<bool> registerFormValidator(String _fullname, String _phoneNo,
      String _email, String _passowrd, context) {
    bool isValid = true;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
    bool phoneNoValid = RegExp("^(?:[0]9)?[0-9]{10}").hasMatch(_phoneNo);
    if (_fullname.isEmpty) {
      Tools().showDesachievementView(context, "Message d'erreur",
          "Vous avez oublié d'entrer votre nom complet, veuillez entrer toutes les informations requises.");
      isValid = false;
    } else if (_phoneNo.isEmpty) {
      Tools().showDesachievementView(context, "Message d'erreur",
          "Vous avez oublié d'entrer votre numéro de téléphone, veuillez entrer toutes les informations requises.");
      isValid = false;
    } else if (!phoneNoValid) {
      Tools().showDesachievementView(context, "Message d'erreur",
          "Veuillez entrer un numéro de téléphone correct.");
      isValid = false;
    } else if (_email.isEmpty) {
      Tools().showDesachievementView(context, "Message d'erreur",
          "Vous oubliez d'entrer votre adresse e-mail.");
      isValid = false;
    } else if (!emailValid) {
      Tools().showDesachievementView(context, "Message d'erreur",
          "Il semble que vous n'ayez pas entré un e-mail correct.");
      isValid = false;
    } else if (_passowrd.isEmpty) {
      Tools().showDesachievementView(context, "Message d'erreur",
          "Vous avez oublié d'entrer votre mot de passe.");
      isValid = false;
    } else if (_passowrd.length < 8) {
      Tools().showDesachievementView(context, "Message d'erreur",
          "Veuillez utiliser un mot de passe fort, 8 caractères ou plus.");
      isValid = false;
    }
    return Future.value(isValid);
  }

  showAlertDialog(BuildContext context, message) {
    // set up the button
    Widget okButton = ElevatedButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
      ),
      child: Text(
        'ok',
        style: TextStyle(
          fontFamily: 'CairoBold',
          fontSize: 14.sp,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
        child: Icon(
          Boxicons.bx_error_alt,
          color: Colors.red,
          size: 50.h,
        ),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'CairoBold',
          fontSize: 14.sp,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
      actions: [
        Center(child: okButton),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> showAlertDialogExit(BuildContext context) {
    bool exit = false;
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Non",
        style: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: () {
        exit = false;
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Oui",
        style: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: () {
        exit = true;
        Future.delayed(const Duration(milliseconds: 1000), () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Quitter l'application",
        style: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: Text(
        "êtes-vous sûr de vouloir quitter l'application ?",
        style: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
          color: const Color.fromRGBO(48, 49, 52, 1),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return Future.value(exit);
  }

  List<DropdownMenuItem<ListItem>>? buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>>? items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  Future<User> saveSession(
      glycemiePreMealT1,
      glycemiePreMealT2,
      glycemiePreMealT3,
      glycemiePostMealT1,
      glycemiePostMealT2,
      glycemiePostMealT3,
      hba1c,
      stepsPerDay) async {
    User user = User.fromJson(await SessionManager().get("currentUser"));
    user.glycPreMealT1 = glycemiePreMealT1;
    user.glycPreMealT2 = glycemiePreMealT2;
    user.glycPreMealT3 = glycemiePreMealT3;
    user.glycPostMealT1 = glycemiePostMealT1;
    user.glycPostMealT2 = glycemiePostMealT2;
    user.glycPostMealT3 = glycemiePostMealT3;
    user.hba1c = hba1c;
    user.stepsPerDay = stepsPerDay;
    user.status = true;
    await SessionManager().set('user', user);
    user = User.fromJson(await SessionManager().get("currentUser"));
    return user;
  }

  Future<bool> useDefaultValue(BuildContext context) {
    bool exit = false;
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Non",
        style: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: () {
        exit = false;
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Oui",
        style: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop();
        exit = true;
        User user = await saveSession(
            '0.69', '1.80', '2.50', '0.69', '1.80', '2.50', '6.0', '10000');
        await Api().completUser(user).then(
          (value) async {
            print(value);
            if (value == "RECORD_CREATED_SUCCESSFULLY") {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: const MainScreen(index: 0),
                  type: PageTransitionType.rightToLeftWithFade,
                ),
              );
            } else {
              Tools().showAlertDialog(context,
                  "Il y a une erreur, veuillez réessayer, si vous rencontrez toujours cette erreur, contactez le support.");
              exit = false;
            }
          },
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Confirmations",
        style: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: Text(
        "Voulez-vous vraiment utiliser les valeurs par défault ?",
        style: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
          color: const Color.fromRGBO(48, 49, 52, 1),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    return Future.value(exit);
  }

  Future<User?> getCurrentUser() async {
    User currentUser;
    currentUser = User.fromJson(await SessionManager().get("user"));
    return currentUser;
  }

  void showAchievementView(BuildContext context, title, subTitle) {
    AchievementView(
      context,
      title: title,
      subTitle: subTitle,
      //onTab: _onTabAchievement,
      icon: Icon(
        Boxicons.bxs_like,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      //typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
      //borderRadius: 5.0,
      color: Colors.green,
      textStyleTitle: TextStyle(
        fontFamily: "CairoSemiBold",
        fontSize: 14.h,
        color: Theme.of(context).scaffoldBackgroundColor,
        height: 1.2,
      ),
      textStyleSubTitle: TextStyle(
        fontFamily: "CairoSemiBold",
        fontSize: 14.h,
        color: Theme.of(context).scaffoldBackgroundColor,
        height: 1.2,
      ),
      alignment: Alignment.bottomCenter,
      duration: const Duration(seconds: 1),
      isCircle: true,
    ).show();
  }

  void showDesachievementView(BuildContext context, title, subTitle) {
    AchievementView(
      context,
      title: title,
      subTitle: subTitle,
      //onTab: _onTabAchievement,
      icon: Icon(
        Boxicons.bxs_dislike,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      //typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
      //borderRadius: 5.0,
      color: Colors.red,
      textStyleTitle: TextStyle(
        fontFamily: "CairoSemiBold",
        fontSize: 14.h,
        color: Theme.of(context).scaffoldBackgroundColor,
        height: 1.2,
      ),
      textStyleSubTitle: TextStyle(
        fontFamily: "CairoSemiBold",
        fontSize: 14.h,
        color: Theme.of(context).scaffoldBackgroundColor,
        height: 1.2,
      ),
      alignment: Alignment.bottomCenter,
      duration: const Duration(seconds: 2),
      isCircle: true,
    ).show();
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hm();
    return format.format(dt);
  }

  bool isValidate(
      String valueOne,
      String valueTwo,
      String valueThree,
      String valueFour,
      String valueFive,
      String valueSix,
      String valueSeven,
      String valueEight) {
    bool success = true;
    if (valueOne.isEmpty) success = false;
    if (valueTwo.isEmpty) success = false;
    if (valueThree.isEmpty) success = false;
    if (valueFour.isEmpty) success = false;
    if (valueFive.isEmpty) success = false;
    if (valueSix.isEmpty) success = false;
    if (valueSeven.isEmpty) success = false;
    if (valueEight.isEmpty) success = false;

    return success;
  }
}

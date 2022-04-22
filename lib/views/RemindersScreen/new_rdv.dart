// ignore_for_file: file_names, must_be_immutable
import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/notification.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/ListItem.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/RemindersScreen/rdv_screen.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';

class NewRdv extends StatefulWidget {
  const NewRdv({Key? key}) : super(key: key);

  @override
  State<NewRdv> createState() => _NewRdvState();
}

class _NewRdvState extends State<NewRdv> {
  bool everyDay = false, _isLoading = false;

  final TextEditingController _aboutController = TextEditingController();
  Color color = const Color.fromRGBO(104, 103, 106, 1);
  late User? currentUser;

  getData() async {
    await Tools().getCurrentUser().then((value) async {
      currentUser = value;
    });
  }

  List<DropdownMenuItem<ListItem>>? _dropdownTypeItems;
  ListItem? _type;

  final List<ListItem> _typeItem = [
    ListItem("-", "Rappelle-moi de"),
    ListItem("Médecin", "Rendez-vous médecin"),
    ListItem("Analyses biologique", "Analyses biologique"),
    ListItem("Autres", "Autres"),
  ];

  String dateD = 'Choisissez la date', time = 'Choisissez l\'heure';
  TimeOfDay selectedTime = TimeOfDay.now();
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
      cancelText: 'Annuler',
      helpText: 'Choisissez l\'heure',
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      selectedTime = timeOfDay;
    }
    setState(() {
      time = Tools().formatTimeOfDay(selectedTime);
      color = Theme.of(context).primaryColorDark;
    });
  }

  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 30),
    );
    setState(() {
      try {
        dateD = DateFormat.yMd().format(date!).toString();
        selectedDate = date;
        color = Theme.of(context).primaryColorDark;
      } catch (e) {
        dateD = 'Choisissez la date';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _dropdownTypeItems = Tools().buildDropDownMenuItems(_typeItem);
    _type = _dropdownTypeItems![0].value;
    getData();
    setState(() {
      _isLoading = false;
    });
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: const RdvScreen(),
                    type: PageTransitionType.fade,
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
                  Boxicons.bxs_chevron_left,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                30.verticalSpace,
                Center(
                  child: Text(
                    'Créer un rendez-vous',
                    style: TextStyle(
                      fontFamily: 'CairoBold',
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                30.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 65.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(235, 235, 235, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: const Icon(
                            Boxicons.bxs_notification,
                            color: Color.fromRGBO(127, 126, 129, 1),
                          ),
                        ),
                        SizedBox(
                          height: 65.h,
                          width: 280.w,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<ListItem>(
                              value: _type,
                              items: _dropdownTypeItems,
                              style: TextStyle(
                                fontFamily: "CairoSemiBold",
                                fontSize: 14.sp,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              iconSize: 20,
                              icon: const Icon(Boxicons.bxs_chevron_down),
                              iconEnabledColor: Colors.grey[800],
                              isExpanded: true,
                              onChanged: (value) {
                                setState(
                                  () {
                                    _type = value;
                                    if (_type!.value == "Autres") {
                                      _aboutController.text = "";
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _type!.value == "Autres" ? 10.verticalSpace : 5.verticalSpace,
                _type!.value == "Autres"
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 65.h,
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            textCapitalization: TextCapitalization.words,
                            controller: _aboutController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontFamily: "NunitoSemiBold",
                              fontSize: 14.sp,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Boxicons.bx_bookmark),
                              hintText: 'Tapez votre rappel',
                              hintStyle: TextStyle(
                                fontFamily: "NunitoRegular",
                                fontSize: 14.sp,
                              ),
                              filled: true,
                              fillColor: const Color.fromRGBO(235, 235, 235, 1),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                5.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(235, 235, 235, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            const Icon(
                              Boxicons.bx_calendar,
                              color: Color.fromRGBO(104, 103, 106, 1),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              dateD,
                              style: TextStyle(
                                fontFamily: "CairoSemiBold",
                                fontSize: 14.sp,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(235, 235, 235, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            const Icon(
                              Boxicons.bx_time,
                              color: Color.fromRGBO(104, 103, 106, 1),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              time,
                              style: TextStyle(
                                fontFamily: "CairoSemiBold",
                                fontSize: 14.sp,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          'Rappelez-moi tous les jours',
                          style: TextStyle(
                            fontFamily: "CairoSemiBold",
                            fontSize: 14.sp,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: everyDay,
                          onChanged: (value) {
                            setState(() {
                              everyDay = value;
                            });
                          },
                          activeTrackColor:
                              const Color.fromRGBO(113, 184, 177, 1),
                          activeColor: const Color.fromRGBO(0, 142, 129, 1),
                        ),
                      ],
                    ),
                  ),
                ),
                40.verticalSpace,
                Center(
                  child: InkWell(
                    onTap: () async {
                      bool valid = true;
                      if (_type!.value == "-") {
                        valid = false;
                        Tools().showDesachievementView(
                            context,
                            "Message d'erreur",
                            "Veuillez compléter toutes les données.");
                      } else if (_type!.value == "Autres") {
                        if (_aboutController.text.isEmpty) {
                          valid = false;
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur",
                              "Veuillez compléter toutes les données.");
                        }
                      } else if (dateD == "Choisissez la date") {
                        valid = false;
                        Tools().showDesachievementView(
                            context,
                            "Message d'erreur",
                            'Veuillez compléter toutes les données.');
                      } else if (time == "Choisissez l'heure") {
                        valid = false;
                        Tools().showDesachievementView(
                            context,
                            "Message d'erreur",
                            'Veuillez compléter toutes les données.');
                      } else if (selectedDate.year == DateTime.now().year &&
                          selectedDate.month == DateTime.now().month &&
                          selectedDate.day == DateTime.now().day) {
                        if (selectedTime.hour < DateTime.now().hour) {
                          valid = false;
                          Tools().showDesachievementView(
                              context,
                              "Message d'erreur",
                              'Veuillez changer la date à une date future');
                          if (selectedTime.minute <= DateTime.now().minute) {
                            valid = false;
                            Tools().showDesachievementView(
                                context,
                                "Message d'erreur",
                                'Veuillez changer la date à une date future');
                          }
                        }
                      }
                      if (valid) {
                        setState(() {
                          _isLoading = true;
                        });
                        DateTime dt = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                        String sousType = "autre";
                        if (_type!.value == "Analyses biologique") {
                          sousType = "ab";
                        }
                        if (_type!.value == "Médecin") {
                          sousType = "rm";
                        }
                        String text = "";
                        _aboutController.text.isEmpty
                            ? text = _type!.value
                            : text = _aboutController.text;
                        await Api()
                            .insertRdv(
                                currentUser?.id,
                                time,
                                dateD,
                                'Vous avez un rendez-vous avec "' + text + '"',
                                sousType)
                            .then(
                          (value) async {
                            NotificationService()
                                .scheduleNotification(
                              int.parse(value),
                              dt,
                              "Glucotel",
                              'Vous avez un rendez-vous avec "' + text + '"',
                              'Rdv',
                              everyDay: everyDay,
                            )
                                .then(
                              (value) {
                                Tools().showAchievementView(
                                    context,
                                    "Ajouté avec succès.",
                                    "Votre rendez-vous a été ajouté avec succès.");
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    child: const RdvScreen(),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
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

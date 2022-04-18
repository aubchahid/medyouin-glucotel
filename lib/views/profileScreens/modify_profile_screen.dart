import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:glucotel/functions/api.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/ListItem.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/widgets/text_field.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ModifyProfilScreen extends StatefulWidget {
  const ModifyProfilScreen({Key? key}) : super(key: key);

  @override
  State<ModifyProfilScreen> createState() => _ModifyProfilScreenState();
}

class _ModifyProfilScreenState extends State<ModifyProfilScreen> {
  User? currentUser;
  bool _loading = false;

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();

  String _birthdateController = 'Date de naissance';
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      locale: const Locale('fr', ''),
    );

    if (picked != null)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        selectedDate = picked;
        _birthdateController = DateFormat('dd-MM-yyyy').format(selectedDate);
        //_isBirthdayEmpty = true;
      });
  }

  List<DropdownMenuItem<ListItem>>? _dropdownSexeItems;
  ListItem? _sexe;
  final List<ListItem> _sexeItems = [
    ListItem("-", "Choisissez votre sexe"),
    ListItem("Homme", "Homme"),
    ListItem("Femme", "Femme"),
  ];

  bool _isFullnameEmpty = false,
      _isSexeEmpty = false,
      _isPhoneNoEmpty = false,
      _isCityEmpty = false;
  bool _isLoading = false, isGoogle = false, _isBirthdayEmpty = true;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _loading = false;
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        await Tools().getCurrentUser().then((value) async {
          setState(() {
            currentUser = value;
            _fullname.text = value!.fullname;
            _email.text = value.email;
            _phoneNo.text = value.phoneNo;
            isGoogle = value.isGoogle;
            _city.text = value.city;
            _birthdateController = value.birthdate;
            _isLoading = true;
            _dropdownSexeItems = Tools().buildDropDownMenuItems(_sexeItems);
            value.sexe == 'Homme'
                ? _sexe = _dropdownSexeItems![1].value
                : _sexe = _dropdownSexeItems![2].value;
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
          body: !_isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      20.verticalSpace,
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
                      InputTextField(
                        hintText: "Entrez votre nom",
                        type: TextInputType.text,
                        controller: _fullname,
                        icon: Boxicons.bxs_user,
                      ),
                      10.verticalSpace,
                      InputTextField(
                        hintText: "Entrez votre adresse e-mail",
                        type: TextInputType.emailAddress,
                        controller: _email,
                        icon: Boxicons.bxs_envelope,
                        enable: false,
                      ),
                      10.verticalSpace,
                      InputTextField(
                        hintText: "Entrez votre ville",
                        type: TextInputType.text,
                        controller: _city,
                        icon: Boxicons.bxs_map_pin,
                      ),
                      10.verticalSpace,
                      InputTextField(
                        hintText: "Entrez votre numéro téléphone",
                        type: TextInputType.phone,
                        controller: _phoneNo,
                        icon: Boxicons.bxs_phone,
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          height: 65.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(235, 235, 235, 1),
                            borderRadius: BorderRadius.circular(12),
                            border: !_isSexeEmpty
                                ? Border.all(
                                    color:
                                        const Color.fromRGBO(231, 230, 235, 1),
                                  )
                                : Border.all(color: Colors.red, width: 2),
                          ),
                          child: SizedBox(
                            height: 65.h,
                            width: 260.w,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<ListItem>(
                                  value: _sexe,
                                  items: _dropdownSexeItems,
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
                                        _sexe = value;
                                        if (_sexe!.value == 'Homme' ||
                                            _sexe!.value == 'Femme') {
                                          _isSexeEmpty = false;
                                        } else {
                                          _isSexeEmpty = true;
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Container(
                            height: 65.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(235, 235, 235, 1),
                              borderRadius: BorderRadius.circular(12),
                              border: _isBirthdayEmpty
                                  ? Border.all(
                                      color: const Color.fromRGBO(
                                          231, 230, 235, 1),
                                    )
                                  : Border.all(color: Colors.red, width: 2),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: const Icon(
                                    Boxicons.bxs_calendar,
                                    color: Color.fromRGBO(127, 126, 129, 1),
                                  ),
                                ),
                                Text(
                                  _birthdateController,
                                  style: TextStyle(
                                    fontFamily: "CairoSemiBold",
                                    fontSize: 14.sp,
                                    color: _isBirthdayEmpty
                                        ? Theme.of(context).primaryColorDark
                                        : const Color.fromRGBO(
                                            127, 126, 129, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      20.verticalSpace,
                      Center(
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              _loading = true;
                            });
                            if (_fullname.text.isEmpty ||
                                _city.text.isEmpty ||
                                _phoneNo.text.isEmpty ||
                                _sexe!.value == "-" ||
                                _birthdateController == 'Date de naissance') {
                              _isFullnameEmpty = _fullname.text.isEmpty;
                              _isCityEmpty = _city.text.isEmpty;
                              _isPhoneNoEmpty = _phoneNo.text.isEmpty;
                              _birthdateController == 'Date de naissance'
                                  ? _isBirthdayEmpty = false
                                  : _isBirthdayEmpty = true;
                              _sexe!.value == '-'
                                  ? _isSexeEmpty = false
                                  : _isSexeEmpty = true;
                            } else {
                              User user = User.fromJson(
                                  await SessionManager().get('user'));
                              setState(() {
                                user.fullname = _fullname.text;
                                user.city = _city.text;
                                user.phoneNo = _phoneNo.text;
                                user.sexe = _sexe!.value;
                                user.birthdate = _birthdateController;
                              });
                              await SessionManager().set('user', user);
                              Api().updaterProfile(user).then((value) {
                                if (value == 'RECORD_UPDATED_SUCCESSFULLY') {
                                  Navigator.pop(context);
                                  Tools().showAchievementView(
                                      context,
                                      'Modification réussie.',
                                      'Vos informations ont été modifiées.');
                                } else {
                                  _loading = false;
                                  Tools().showAlertDialog(context,
                                      "il semble qu'il y ait une erreur, vous pouvez essayer dans quelques secondes");
                                }
                              });
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

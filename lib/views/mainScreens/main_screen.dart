import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glucotel/functions/tools.dart';
import 'package:glucotel/model/user.dart';
import 'package:glucotel/views/coming_soon_screen.dart';
import 'package:glucotel/views/mainScreens/home_screen.dart';
import 'package:glucotel/views/mainScreens/reminders_screen.dart';
import 'package:glucotel/views/mainScreens/stats_screen.dart';
import 'package:glucotel/widgets/NavigationDrawerWidget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainScreen extends StatefulWidget {
  final int index;

  const MainScreen({required this.index, Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProvidedStylesExample(
          menuScreenContext: context,
          index: widget.index,
        ),
      ),
    );
  }
}

class ProvidedStylesExample extends StatefulWidget {
  final BuildContext menuScreenContext;
  final int index;

  // ignore: use_key_in_widget_constructors
  const ProvidedStylesExample({
    required this.menuScreenContext,
    required this.index,
  });

  @override
  _ProvidedStylesExampleState createState() =>
      // ignore: no_logic_in_create_state
      _ProvidedStylesExampleState(index);
}

class _ProvidedStylesExampleState extends State<ProvidedStylesExample> {
  int index;

  _ProvidedStylesExampleState(this.index);

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const MyStats(),
      const RemindersScreens(),
      const UpComming(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Boxicons.bxs_home,
          size: 18.sp,
        ),
        title: ("Accueil"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Theme.of(context).primaryColor,
        textStyle: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
          color: Colors.white,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Boxicons.bxs_pie_chart,
          size: 18.sp,
        ),
        title: ("Suivi"),
        activeColorPrimary: Theme.of(context).primaryColor,
        textStyle: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Boxicons.bxs_alarm,
          size: 18.sp,
        ),
        title: ("Rappels"),
        activeColorPrimary: Theme.of(context).primaryColor,
        textStyle: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Boxicons.bxs_chat,
          size: 18.sp,
        ),
        title: ("Chat"),
        activeColorPrimary: Theme.of(context).primaryColor,
        textStyle: TextStyle(
          fontFamily: "CairoBold",
          fontSize: 14.sp,
        ),
      ),
    ];
  }

  bool drawerHeaderShadow = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  User? currentUser;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        Tools().getCurrentUser().then((value) async {
          setState(() {
            currentUser = value;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: SafeArea(
        child: Scaffold(
          key: _key,
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                _key.currentState!.openDrawer(); // Create a key
              },
              child: Icon(
                Boxicons.bx_grid_alt,
                size: 28.h,
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
          drawer: NavigationDrawerWidget(
            currentUser: currentUser,
          ),
          body: PersistentTabView(
            context,
            onItemSelected: (value) => setState(() => index = value),
            screens: _buildScreens(),
            items: _navBarsItems(),
            controller: PersistentTabController(
              initialIndex: index,
            ),
            confineInSafeArea: true,
            decoration: NavBarDecoration(
              border: const Border.fromBorderSide(BorderSide.none),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40.sp),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColorDark.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 40,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
              colorBehindNavBar: const Color.fromRGBO(250, 250, 250, 1),
            ),
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            navBarHeight: 80.h,
            hideNavigationBarWhenKeyboardShows: false,
            margin: const EdgeInsets.all(0.0),
            //popActionScreens: PopActionScreensType.once,
            bottomScreenMargin: MediaQuery.of(context).viewInsets.bottom > 0
                ? 0.0
                : kBottomNavigationBarHeight,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.bounceIn,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle
                .style1, // Choose the nav bar style with this property
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:todoapp/core/assets_path.dart';
import 'package:todoapp/core/string_lbl.dart';
import 'package:todoapp/core/widget/custom_svg_picture.dart';

import '../../../../core/styles.dart';
import '../../../../core/utils.dart';
import '../../../home/presentation/screens/home_screen.dart';


 class NavMainScreen extends StatefulWidget {
   const NavMainScreen({super.key});

   @override
   State<NavMainScreen> createState() => _NavMainScreenState();
 }

 class _NavMainScreenState extends State<NavMainScreen> {

   late PersistentTabController _controller;
   late bool _showNavBar;
   DateTime? backButtonPressTime;
   static const flutterToastDuration = const Duration(seconds: 3);

    @override
   Widget build(BuildContext context) {
     return
       SafeArea(
top: false,
         child: Scaffold(
               // key: sl<NavigationService>().scaffoldKey,
         resizeToAvoidBottomInset: true,

               body: WillPopScope(
          onWillPop: () async {

              final currentTime = DateTime.now();
              final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
                  backButtonPressTime == null ||
                      currentTime.difference(backButtonPressTime!) >
                          flutterToastDuration;
              if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
                backButtonPressTime = currentTime;

                Utils.showToast(StringLbl
                    .pressTwiceToExit);
                return false;
              } else {
                SystemNavigator.pop();

                return true;
              }
            },
          child:



          Container(
            decoration: Styles.gradientRoundedDecoration(
              gradientColor: [Styles.colorBackgroundGradientStart,Styles.colorBackgroundGradientEnd],


            ),
            width:double.maxFinite,
            height: double.maxFinite,
            child: PersistentTabView(
              context,
               navBarHeight: 84.h,
              controller: _controller,

              screens: _buildScreens(),

              resizeToAvoidBottomInset: true,
              hideNavigationBarWhenKeyboardAppears:   true,
            navBarStyle: NavBarStyle.simple,
            backgroundColor: Styles.colorBackgroundNavBar,
              handleAndroidBackButtonPress: true,
              stateManagement: true,
              isVisible:  _showNavBar
              ,


               animationSettings: NavBarAnimationSettings(
              screenTransitionAnimation:
              ScreenTransitionAnimationSettings(
                 animateTabTransition: true,
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 300),
              )
              ),

              items: _navBarsItems(),

              decoration: NavBarDecoration(
                colorBehindNavBar: Styles.colorBackground ,
                   borderRadius: BorderRadius.only(
                     topRight:  Radius.circular(20.r),
                    topLeft: Radius.circular(20.r),
                  ),
                  boxShadow: [
              BoxShadow(
              color: Styles.colorShadow.withOpacity(0.02) ,
              spreadRadius: 0,
              offset: Offset(-2,-3),


              blurRadius: 3,
            ),     ]
              ),
            ),
          ),
               ),
             ),
       );
  }

  List<Widget> _buildScreens() {
    List<Widget> screens = [];

       screens.add(HomeScreen());
       screens.add(Scaffold(

           resizeToAvoidBottomInset: true,
           body: Container(
               decoration: Styles.gradientRoundedDecoration(
                 radius: 0.r,

                 gradientColor: [Styles.colorBackgroundGradientStart,Styles.colorBackgroundGradientEnd],

               ),
               width: double.maxFinite,
               height: double.maxFinite,
           )));
    screens.add(Scaffold(

        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: Styles.gradientRoundedDecoration(
            radius: 0.r,

            gradientColor: [Styles.colorBackgroundGradientStart,Styles.colorBackgroundGradientEnd],

          ),
          width: double.maxFinite,
          height: double.maxFinite,
        )));

    return screens;

  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final activeColor = Styles.colorIconActive;
    final inactiveColor = Styles.colorIconInActive.withOpacity(0.8) ;

    return [
         PersistentBottomNavBarItem(
          activeColorPrimary: activeColor,
          inactiveColorPrimary: inactiveColor,
          icon:CustomPicture(
            path: AssetsPath.SVGNAVBarHome,
            height: 30.r, width: 30.r,
            color: activeColor ,

            isSVG: true,

          ),
           inactiveIcon:CustomPicture(
           path: AssetsPath.SVGNAVBarHome,
           height: 30.r, width: 30.r,
            color: inactiveColor,
             isSVG: true,

         ),
         ),
      PersistentBottomNavBarItem(
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        icon:CustomPicture(
          isSVG: true,
          path: AssetsPath.SVGNAVBarCompass,
          height: 30.r, width: 30.r,
          color: activeColor ,


        ),
        inactiveIcon:CustomPicture(
          path: AssetsPath.SVGNAVBarCompass,
          height: 30.r, width: 30.r,
          color: inactiveColor,
          isSVG: true,

        ),
      ),

      PersistentBottomNavBarItem(
          activeColorPrimary: activeColor,
          inactiveColorPrimary: inactiveColor,
          icon:CustomPicture(
            path: AssetsPath.SVGNAVBarProfile,
            height: 30.r, width: 30.r,
            color: activeColor ,
            isSVG: true,


          ),
           inactiveIcon:CustomPicture(
           path: AssetsPath.SVGNAVBarProfile,
           height: 30.r, width: 30.r,
            color: inactiveColor,
             isSVG: true,

         ),
         ),

    ];
  }

  @override
  void initState() {
    super.initState();
     _controller = PersistentTabController(initialIndex: 0);

     // _controller = PersistentTabController(
    //   initialIndex: managementNavController.value.index,
    // );
    // _controller.addListener(() {
    //   final _patientsCurrentState = _patientsKey.currentState;
    //   if (_controller.index != 3) {
    //     if (_patientsCurrentState?.searchController.text.isNotEmpty ?? false) {
    //       _patientsCurrentState?.searchController.clear();
    //       _patientsCurrentState?.resetSearch();
    //     }
    //   }
    //   if (_controller.index == 3) {
    //     FocusManager.instance.primaryFocus?.unfocus();
    //   }
    //   if (mounted) {
    //     setState(() {
    //       navIndex = _controller.index;
    //     });
    //   }
    // });
    // _controller.addListener(() {
    //   final _appointmentsCurrentState = _appointmentsKey.currentState;
    //   if (_controller.index != 1) {
    //     if (_appointmentsCurrentState?.searchController.text.isNotEmpty ??
    //         false) {
    //       _appointmentsCurrentState?.lastKeyword = '';
    //       _appointmentsCurrentState?.searchController.clear();
    //       _appointmentsCurrentState?.resetFilters();
    //     }
    //   }
    //   if (_controller.index == 1) {
    //     FocusManager.instance.primaryFocus?.unfocus();
    //     if (sl<AppointmentRepository>().selectedAppointmentFilter.statusId ==
    //             AppointmentStatus.upcoming.index ||
    //         sl<AppointmentRepository>().selectedAppointmentFilter.statusId ==
    //             null) {
    //       _appointmentsCurrentState?.requestAppointments(
    //         sl<AppointmentRepository>().selectedAppointmentFilter,
    //       );
    //     }
    //   }
    //   if (mounted) {
    //     setState(() {
    //       navIndex = _controller.index;
    //     });
    //   }
    // });
    // managementNavController.listen((value) {
    //   if (value.index == _controller.index) {
    //     return;
    //   }
    //   _controller.jumpToTab(value.index);
    // });
    _showNavBar = true;
  }

  @override
  void dispose() {
    super.dispose();
  }
}


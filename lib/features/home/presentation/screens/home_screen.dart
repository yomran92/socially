
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todoapp/core/assets_path.dart';

import 'package:todoapp/core/utils/common_sizes.dart';

import 'package:todoapp/core/widget/custom_svg_picture.dart';

import '../../../../core/styles.dart';

import '../../../../core/widget/social_app_bar.dart';


import '../components/story_widget.dart';


const String progressIndicatorKey = "PROGRESS INDICATOR KEY";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   bool _enablePullUp = true;
  int _currentSection = 1;
  final _refreshController = RefreshController();

  @override
  void dispose() {
    super.dispose();
  }




  ValueNotifier<bool> showComment = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

resizeToAvoidBottomInset: true,
        body: Container(
          decoration: Styles.gradientRoundedDecoration(
            radius: 0.r,

            gradientColor: [Styles.colorBackgroundGradientStart,Styles.colorBackgroundGradientEnd],

          ),
            width: double.maxFinite,
            height: double.maxFinite,

                 child:
                SingleChildScrollView(
                  child: Column(children: [
                    // CommonSizes.vBiggerSpace,
                    SocialAppBar(
                      tail: [Row(children: [


                        CustomPicture(path: AssetsPath.SVGSocially,

                            isSVG: true,
                            height: 23.h, width: 144.w)
                      ],)],
                    ),

                    CommonSizes.vSmallerSpace,

                    StoryWidget(),
                    CommonSizes.vSmallerSpace,


                   ],),
                )

            ));
  }
}

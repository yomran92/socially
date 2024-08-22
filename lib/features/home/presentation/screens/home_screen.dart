import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socially/core/assets_path.dart';
import 'package:socially/core/utils/common_sizes.dart';
import 'package:socially/core/widget/custom_svg_picture.dart';

import '../../../../core/styles.dart';
import '../../../../core/widget/social_app_bar.dart';import '../../../post/presentation/screen/post_widget.dart';
import '../components/story_widget.dart';

const String progressIndicatorKey = "PROGRESS INDICATOR KEY";
class  HomeScreen extends StatelessWidget {
  const HomeScreen ({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            decoration: Styles.gradientRoundedDecoration(
              radius: 0.r,
              gradientColor: [
                Styles.colorBackgroundGradientStart,
                Styles.colorBackgroundGradientEnd
              ],
            ),
            width: double.maxFinite,
            height: double.maxFinite,
               child: Column(
                children: [
                   SocialAppBar(
                    tail: [
                      Row(
                        children: [
                          CustomPicture(
                              path: AssetsPath.SVGSocially,
                              isSVG: true,
                              height: 23.h,
                              width: 144.w)
                        ],
                      )
                    ],
                  ),

                  CommonSizes.vSmallerSpace,

                  StoryWidget(),
                  CommonSizes.vSmallerSpace,
                Expanded(child:    PostListWidget()),
                ],
              ),
            ));
  }
}

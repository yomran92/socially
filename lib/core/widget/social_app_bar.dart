import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socially/core/assets_path.dart';
import 'package:socially/core/widget/custom_svg_picture.dart';

import '../utils/common_sizes.dart';

class SocialAppBar extends StatelessWidget {
  const SocialAppBar({
    Key? key,
    this.title = '',
    this.onPressed,
    this.tail,
    this.withNotification = true,
    this.padding,
    this.backgroundColor,
  }) : super(key: key);

  final String title;
  final List<Widget>? tail;
  final void Function()? onPressed;
  final bool withNotification;
  final EdgeInsets? padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final orientation = ScreenUtil().orientation;
    // final fontSize = orientation == Orientation.landscape
    //     ? Styles.fontSize7
    //     : Styles.fontSize1;
    return Container(
      height: 53.h + 25.h,
      padding: padding ??
          EdgeInsets.only(
            left: CommonSizes.Size_24_HGAP,
            right: CommonSizes.Size_24_HGAP,
            top: 53.h,
          ),
      // decoration: BoxDecoration(
      //   color: backgroundColor ?? Styles.colorBackground,
      // ),
      child:
          // child: InkWell(
          //   onTap: withProfilePicture
          //       ? () {
          //     // Utils.pushNewScreenWithRouteSettings(
          //     //   context,
          //     //   settings: const RouteSettings(
          //     //     name: RoutePaths.profileScreen,
          //     //   ),
          //     //   withNavBar: false,
          //     //   screen: const ProfileScreen(),
          //     // );
          //   }
          //       : null,
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (withNotification)
            CustomPicture(
              path: AssetsPath.SVGNotification,
              height: 25.r,
              width: 25.r,
              isSVG: true,
            ),
          if (!withNotification)
            SizedBox(
              height: 25.r,
              width: 25.r,
            ),
          if (tail != null && (tail?.length ?? 0) > 0) ...tail!,
          if (withNotification)
            SizedBox(
              // path: AssetsPath.SVGNotification,
              height: 25.r,
              width: 25.r,
            ),
          if (!withNotification)
            SizedBox(
              height: 25.r,
              width: 25.r,
            ),
        ],
      ),
      // ),

      // )
    );
  }
}

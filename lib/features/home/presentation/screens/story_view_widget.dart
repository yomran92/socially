import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socially/core/assets_path.dart';
import 'package:socially/core/utils.dart';
import 'package:socially/core/utils/common_sizes.dart';
import 'package:socially/core/widget/custom_svg_picture.dart';

import '../../../../core/styles.dart';
import '../../../../core/widget/custom_rich_text.dart';
import '../../../../core/widget/custom_text.dart';
import '../../domain/entities/get_story_entity.dart';

class StoryViewer extends StatefulWidget {
  final GetStoryEntity story;

  StoryViewer({required this.story});

  @override
  _StoryViewerState createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  @override
  void initState() {
    super.initState();

    _startStoryTimer();
  }

  void _startStoryTimer() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          bottom: false,
         left: false,
         right: false,
         child: Scaffold(
          body: Container(
            decoration: Styles.gradientRoundedDecoration(
              radius: 0.r,
              gradientColor: [
                Styles.colorStorygradient1.withOpacity(0.1),
                Styles.colorStorygradient2.withOpacity(0.1),
                Styles.colorStorygradient3.withOpacity(0.1),
              ],
              alignmentGeometryBegin: Alignment(0.5, 0),
              alignmentGeometryEnd: Alignment(0.5, 1),
            ),
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child:
                CustomPicture(

                      path:  widget.story.image??'',

                  isSVG: false,
                  fit: BoxFit.fill,

                )),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    child: LinearProgressIndicator(
                      minHeight: 5,
                      backgroundColor: Colors.grey[400],
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  height: 52.h,
                  top: CommonSizes.Size_12_VGAP,
                  left: CommonSizes.Size_20_HGAP,
                  right: CommonSizes.Size_20_HGAP,
                  child: Row(
                    children: [
                     InkWell(onTap: (){
                       Utils.popNavigate(context);
                     },child:   Container(
                        width: 52.h,
                        height: 52.h,
                        decoration: Styles.coloredRoundedDecoration(
                            radius: 10.r,
                            color: Styles.colorBackgroundContanier,
                            borderColor: Styles.colorBackgroundContanier),
                        child: Container(
                          width: 23.h,
                          height: 23.h,
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Styles.colorBackArrowIcon,
                          ),
                        ),
                      )
                     ),
                      CommonSizes.hSmallestSpace,
                      CustomRichText(
                        text: [
                          new TextSpan(
                              text: widget.story.name??'',
                              style: Styles.w600TextStyle().copyWith(
                                  color: Styles.colorTextWhite,
                                  fontSize: 20.sp)),
                          new TextSpan(
                              text: '2 d ago',
                              style: Styles.w600TextStyle().copyWith(
                                  color: Styles.colorTextWhite,
                                  fontSize: 16.sp)),
                        ],
                      ),
                      Spacer(),
                      CustomPicture(
                        path: widget.story.image??'',
                        isSVG: false,
                        width: 23.h,
                        height: 23.h,
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 55.h,
                  height: 52.h,
                  right: CommonSizes.Size_20_HGAP,
                  child: CustomPicture(
                    path: AssetsPath.SVGLike,
                    isSVG: true,
                    width: 23.h,
                    height: 23.h,
                  ),
                ),
                Positioned(
                  height: 44.h,
                   right: 150.h,
                  bottom: 100.h,
                  child: Container(
                    decoration: Styles.coloredRoundedDecoration(
                        radius: 20.r,
                        color: Styles.colorBackgroundWithIconContanier,
                        borderColor: Styles.colorBackgroundWithIconContanier),
                    padding: EdgeInsets.symmetric(
                        horizontal: CommonSizes.Size_12_HGAP,
                        vertical: CommonSizes.Size_8_VGAP),
                    child: Row(
                      children: [
                        CustomPicture(
                          path: AssetsPath.SVGpurchase,
                          isSVG: true,
                          width: 13.h,
                          height: 13.h,
                        ),
                        CustomText(
                          text: 'Mediatiobn',
                          style: Styles.w500TextStyle().copyWith(
                              fontSize: 14.sp,
                              color: Styles.colorBackArrowIcon),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

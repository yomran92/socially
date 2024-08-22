import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/core/assets_path.dart';
import 'package:todoapp/core/styles.dart';
import 'package:todoapp/core/utils.dart';
import 'package:todoapp/core/widget/custom_svg_picture.dart';
import 'package:todoapp/core/widget/custom_text.dart';
import 'package:todoapp/features/home/presentation/screens/story_view_widget.dart';
import 'package:todoapp/features/task/data/models/param/delete_task_param.dart';

import '../../../../core/routing/route_paths.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../service_locator.dart';
import '../../../task/domain/entities/get_task_entity.dart';


class StoryWidget extends StatelessWidget {

  const StoryWidget({Key? key, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
  height: 76.h,
  margin:  EdgeInsets.only(

      left: CommonSizes.Size_24_HGAP,
      right: CommonSizes.Size_24_HGAP,),
  padding: EdgeInsets.only(top: CommonSizes.Size_8_HGAP ,bottom:  CommonSizes.Size_8_HGAP,),
 decoration: Styles.gradientRoundedDecoration(
     radius: 48.r,
     alignmentGeometryBegin: Alignment(0, 0),
     alignmentGeometryEnd: Alignment(0, 1),

     gradientColor: [
       Styles.colorBackgroundGradientStart,
       Styles.colorBackgroundGradientEnd
     ],

     boxShadow: [
   BoxShadow(
     color: Styles.colorShadow.withOpacity(0.1) ,
     spreadRadius: 0,
     offset: Offset(0,2),

     blurRadius: 9,
   ),     ]
 ),
child:




Container(

  child:ClipRRect(

borderRadius:

    BorderRadius.circular(48.r),

child:






ListView.separated(
padding: EdgeInsets.only(left: 8.h),
     separatorBuilder: (context,index)=>CommonSizes.hSmallerSpace,
       itemCount: 20,

  scrollDirection: Axis.horizontal,

  shrinkWrap: true,
   itemBuilder:
(context, index) =>
GestureDetector(onTap: (){
  final List<String> storyImages = [
    'https://via.placeholder.com/400x700/FF0000/FFFFFF?text=Story+1',

  ];
// Utils.pushNewScreenWithRouteSettings(
//     context,
//   settings: RouteSettings(name: RoutePaths.stroyViewPage ),
//
//   screen: StoryViewer(
//       // images: storyImages,
//       // initialIndex: index,
//     ),
//     withNavBar: true
//   ,
// );
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => StoryViewer(
        images: storyImages,
        initialIndex: index,
      ),
    ),
  );
},child:
     CustomPicture(path: AssetsPath.PNGPerson,
    height: 56.h,
isCircleShape: true,
    isSVG: false,
    withBorder: true,
    width: 56.h ),
)),
)  ) );
  }
}

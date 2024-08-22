import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socially/core/string_lbl.dart';

import '../../../../core/assets_path.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/widget/custom_rich_text.dart';
import '../../../../core/widget/custom_svg_picture.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../commet/presentation/screen/comment_widget.dart';
import '../../domain/entities/get_post_entity.dart';

class PostCard extends StatelessWidget {
    PostCard({required this.postEntity,required this.isImage,super.key});
  GetPostEntity postEntity;
  bool isImage;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin:  EdgeInsets.only(

        left: CommonSizes.Size_12_HGAP,
        right: CommonSizes.Size_12_HGAP,),
      padding: EdgeInsets.all(CommonSizes.Size_12_HGAP,),
      decoration: Styles.coloredRoundedDecoration(radius:20.r ),
      child:
      Column(children: [
        Container(
            height: 25.h,
            width: 376.w,child:   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomPicture(path: AssetsPath.PNGPerson,
                height: 25.r, width:25.r),
            Expanded(child:
            CustomRichText(

              textAlign:     TextAlign.start,

              text: [
              new TextSpan(
                  text:postEntity.title!.substring(0,10),
                  style:  Styles.w500TextStyle().copyWith(fontSize: 16.sp)),
              new TextSpan(
                  text:'.With Zoe Sugg ',
                  style:  Styles.w500TextStyle().copyWith(fontSize: 14.sp)),


            ], )),
            CustomText(text: '2 d ago', style:
            Styles.w500TextStyle().copyWith(fontSize: 14.sp,


                color: Styles.colorTextInactive.withOpacity(0.6))),


          ],)),
        CommonSizes.vSmallestSpace,
         isImage? CustomRichText(
          textAlign:     TextAlign.justify,

          text:   [  new TextSpan(
              text: postEntity.body??'',
              style: Styles.w600TextStyle().copyWith(
                  color: Styles.colorTextTitle,
                  overflow: TextOverflow.clip,

                  fontSize: 16.sp))],

          textWithemogi:postEntity.body!+
          StringLbl.textEx,  withtextWithemogi: isImage,

        ):
        CustomPicture(path: AssetsPath.SVGNAVBarProfile,
           height: 40.h,
          width: 40.w,
        ),
        CommonSizes.vSmallestSpace,

        Container(color:Styles.colorDivider.withOpacity(0.6) ,height: 1,),
        CommonSizes.vSmallerSpace,

        Container(
            height: 25.r,
            margin: EdgeInsets.symmetric(horizontal: CommonSizes.Size_12_HGAP),
            child:   Row(
              children: [
                CustomPicture(path: AssetsPath.SVGLike,isSVG: true,
                  height: 25.r,
                  width: 25.r,),
                CommonSizes.h4Space,
                CustomText(text: postEntity.reactions!.likes.toString(),
                  isNumberFormat: true,
                  style:  Styles.w500TextStyle().copyWith(fontSize: 14.sp,color: Styles.colorTextTitle)

                  ,),
                CommonSizes.hSmallestSpace,

                InkWell(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useRootNavigator: true,
                        builder: (context) => CommentBottomSheet(postID: postEntity!.id!,),
                      );
                    },

                    child:   CustomPicture(path: AssetsPath.SVGComment,isSVG: true,
                      height: 25.r,
                      width: 25.r,)),
                CustomText(text: postEntity.views.toString(),
                  isNumberFormat: true,
                  style:  Styles.w500TextStyle().copyWith(fontSize: 14.sp,color: Styles.colorTextTitle)
                  ,),
                Spacer(),
                CustomPicture(path: AssetsPath.SVGShare,isSVG: true,
                  height: 25.r,
                  width: 25.r,),
              ],)),



      ],),
    );
  }
}

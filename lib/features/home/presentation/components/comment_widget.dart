import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/string_lbl.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/custom_text_field.dart';


class CommentBottomSheet extends StatefulWidget {
  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  List<CommentWidget> comments = [
    CommentWidget(
      userName: 'User1',
      text: 'This is a comment',
      dateTime: '2 hours ago',
      replies: [
        CommentWidget(
          userName: 'User2',
          text: 'This is a reply',
          dateTime: '1 hour ago',
          isReply: true,
        ),
        CommentWidget(
          userName: 'User3',
          text: 'Another reply',
          dateTime: '30 minutes ago',
          isReply: true,
        ),
      ],
    ),
    CommentWidget(
      userName: 'User4',
      text: 'Another comment',
      dateTime: '1 day ago',
    ),
  ];

  final TextEditingController _commentController = TextEditingController();

  void _addNewComment(String text) {
    setState(() {
      comments.add(CommentWidget(
        userName: 'CurrentUser',
        text: text,
        dateTime: 'Just now',
      ));
    });
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return Container(



          padding: EdgeInsets.all( CommonSizes.Size_12_HGAP

               ,),
          decoration: Styles.gradientRoundedDecoration(
              radius: 48.r,
              alignmentGeometryBegin: Alignment(0, 0),
              alignmentGeometryEnd: Alignment(0, 1),
              customBorder:BorderRadius.only(topLeft:Radius.circular(48.r) ,topRight:Radius.circular(48.r)  ) ,
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

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40.w,
                height: 5.h,
                decoration:  Styles.coloredRoundedDecoration(
                    radius: 48.r,
                     color: Styles.colorBackgroundAppBar,

                ),
              ),
             CommonSizes.vSmallerSpace,
              CustomText(text: 'Comments',
                 textAlign:TextAlign.center ,
                 alignmentGeometry: Alignment.center,
                 style:  Styles.w600TextStyle().copyWith(fontSize: 18.sp,color: Styles.colorTextWhite)

                ,),
               Expanded(
                child: ListView(
                  controller: scrollController,
                  children: comments,
                ),
              ),
              Row(
                children: [
              Expanded(child:  CustomTextField(
                height: 56.h,
                // width: 217.w,
                justLatinLetters: true,
                // textKey: _usernameFocusNodesernameKey,
                controller: _commentController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (Validators.isNotEmptyString(value ?? '')) {
                    return null;
                  }
                  setState(() {});
                  return "${StringLbl.validationMessage} ${StringLbl.userName}";
                },
                textStyle: Styles.w400TextStyle()
                    .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
                textAlign: TextAlign.left,
                // focusNode: _usernameFocusNode,
                hintText: "Add a comment...",
                minLines: 1,
                onChanged: (String value) {
                  // if (_usernameKey.currentState!.validate()) {}
                  setState(() {});
                },
                maxLines: 1,
                onFieldSubmitted: (String value) {},
              )),
                  IconButton(
                    icon: Icon(Icons.send, color: Styles.colorTextWhite),
                    onPressed: () {
                      if (_commentController.text.isNotEmpty) {
                        _addNewComment(_commentController.text);
                      }
                    },
                  )  ]),
              CommonSizes.vSmallestSpace
             ],
          ),
        );
      },
    );
  }
}

class CommentWidget extends StatelessWidget {
  final String userName;
  final String text;
  final String dateTime;
  final bool isReply;
  final List<CommentWidget>? replies;

  CommentWidget({
    required this.userName,
    required this.text,
    required this.dateTime,
    this.isReply = false,
    this.replies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(
        left: isReply ? CommonSizes.Size_24_VGAP : CommonSizes.Size_16_VGAP ,
        right: CommonSizes.Size_16_VGAP,
        top: CommonSizes.Size_8_HGAP,
        bottom:  CommonSizes.Size_8_HGAP
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                child:
                CustomText(text: userName[0],
                  textAlign:TextAlign.center ,
                  alignmentGeometry: Alignment.center,
                  style:  Styles.w500TextStyle().copyWith(fontSize: 16.sp,color: Styles.colorPrimary)

                  ,),

               ),
CommonSizes.hSmallestSpace,
              CustomText(text: userName,
                textAlign:TextAlign.center ,
                alignmentGeometry: Alignment.center,
                style:  Styles.w500TextStyle().copyWith(fontSize: 16.sp,color: Styles.colorTextWhite)

                ,),
             ],
          ),
          CommonSizes.vSmallestSpace,
          CustomText(text: text,
              style:  Styles.w300TextStyle().copyWith(fontSize: 14.sp,color: Styles.colorTextWhite)

            ,),
          CommonSizes.vSmallestSpace,
          Row(
            children: [
              CustomText(text: "Reply",
                style:  Styles.w700TextStyle().
                copyWith(fontSize: 14.sp,color: Styles.colorReplay  )

                ,),
              CommonSizes.hSmallerSpace,

              Text(dateTime, style: TextStyle(color: Colors.grey)),
            ],
          ),
          CommonSizes.vSmallerSpace,

          if (replies != null)
            Container(
             padding: EdgeInsets.only(
    left:   CommonSizes.Size_16_VGAP ,
    right: CommonSizes.Size_16_VGAP,
    top: CommonSizes.Size_8_HGAP,
    bottom:  CommonSizes.Size_8_HGAP
    ),
              child: Column(children: replies!),
            ),
        ],
      ),
    );
  }
}

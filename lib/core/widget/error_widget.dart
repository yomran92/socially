import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socially/core/string_lbl.dart';

import '../styles.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class ErrorWidgetScreen extends StatelessWidget {
  final String message;
  final Function callBack;
  final double? height;
  final double? width;
  final bool? isHorizontal;

  const ErrorWidgetScreen(
      {required this.message,
      required this.callBack,
      this.width,
      this.height,
      this.isHorizontal=false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Styles.colorPrimary.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child:

            (isHorizontal??false)?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(



                  child: CustomButton(
                    // height: (height ?? 25) * 0.2,
                    text: StringLbl.reload  ,
                    style: Styles.w500TextStyle().copyWith(
                        color: Styles.colorTextWhite, fontSize: 20.sp),
                    textAlign: TextAlign.center,
                    color:  Colors.transparent,
                    fillColor: Colors.transparent,

                    alignmentDirectional: AlignmentDirectional.center,
                    onPressed: callBack,
                  ),
                ),
              ],
            ):
            Column(
               crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Center(
                    child: CustomText(
                  text: message ?? "",
                  style: Styles.w500TextStyle().copyWith(
                    fontSize: 16.sp,
                    color: Styles.colorTextError,
                  ),
                  textAlign: TextAlign.center,
                  alignmentGeometry: Alignment.center,
                )),

                Container(
                   margin:
                      EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),

                  child: CustomButton(
                    height: (height ?? 25) * 0.2,
                    text: StringLbl.reload,
                    style: Styles.w500TextStyle().copyWith(
                        color: Styles.colorTextWhite, fontSize: 20.sp),
                    textAlign: TextAlign.center,
                    color:  Colors.transparent,
                    fillColor: Colors.transparent,
                    alignmentDirectional: AlignmentDirectional.center,
                    onPressed: callBack,
                  ),
                ),
                // SizedBox(height: height*0.05,),
              ],
            )),
      ),
    );
  }
}

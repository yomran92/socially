import 'dart:ui';

import 'package:flutter/material.dart';
 import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:todoapp/core/styles.dart';
import 'package:todoapp/core/widget/custom_button_with_icon.dart';


import '../../../../core/string_lbl.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widget/custom_text_field.dart';



class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget();

  @override
  State<StatefulWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
 
  final _commentController = TextEditingController();

  FocusNode _commentFocusNode = FocusNode();

  final GlobalKey<FormFieldState<String>> _commentKey =
  new GlobalKey<FormFieldState<String>>();

  @override
  void dispose() {
    _commentController.dispose();
     super.dispose();
  }
  ValueNotifier<bool> enableSend = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child:   Container(
                   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).padding.top,
                        ),

                        _buildcomment(),


                       ],
                    ),
                  )),
     );
  }

  @override
  void initState() {
    _commentController.text = '' ;
     super.initState();
  }

  _buildcomment() {
    return CustomTextField(
      height: 56.h,
      // width: 217.w,
      justLatinLetters: true,
      textKey: _commentKey,
      controller: _commentController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (Validators.isNotEmptyString(value ?? '')) {
          return null;
        }
        setState(() {});
        return "${StringLbl.validationMessage} 'comment";
      },
      textStyle: Styles.w400TextStyle()
          .copyWith(fontSize: 16.sp, color: Styles.colorTextTextField),
      textAlign: TextAlign.left,
      focusNode: _commentFocusNode,
      hintText: 'comment',
      minLines: 1,suffixIcon :
    ValueListenableBuilder<bool>(
    valueListenable: enableSend,
    builder: (context, enableSend, widget) {
    return

CustomButtonWithIcon(
  height:25.r,width: 25.r,

    icon:
Icon(Icons.send,color: enableSend?Styles.colorPrimary:Styles.colorPrimary.withOpacity(0.5),

    ) , onPressed:  (){

})  ;  }),
      onChanged: (String value) {
        if (_commentKey.currentState!.validate()) {}

        enableSend.value  =_commentController.text.isNotEmpty;
      },
      maxLines: 1,
      onFieldSubmitted: (String value) {},
    );
  }


  // _buildBtnLogin() {
  //   return BlocConsumer<AccountBloc, AccountState>(
  //       bloc: sl<AccountBloc>(),
  //       listener: (context, AccountState state) async {
  //         if (state is AccountLoading) {
  //         } else if (state is AccountError) {
  //           HelperFunction.showToast(state.message.toString());
  //         } else if (state is LogInLoaded) {
  //           final userBox = await sl<HiveParamter>().hive.box(HiveKeys.userBox);
  //           userBox.clear();
  //           userBox.add(state.logInEntity!.userModel);
  //           //save User
  //           sl<AppStateModel>().setUser(state.logInEntity!.userModel);
  //
  //           Utils.popNavigateToFirst(context);
  //           Utils.pushReplacementNavigateTo(
  //             context,
  //             RoutePaths.TaskScreen,
  //           );
  //         }
  //       },
  //       builder: (context, state) {
  //         if (sl<AccountBloc>().state is AccountLoading) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         return Center(
  //           child: CustomButton(
  //             text: StringLbl.login,
  //
  //             style: Styles.w600TextStyle()
  //                 .copyWith(fontSize: 14.sp, color: Styles.colorTextWhite),
  //             raduis: 14.r,
  //             textAlign: TextAlign.center,
  //             color: Styles.colorPrimary,
  //             fillColor: Styles.colorPrimary,
  //             // width: 350.w,
  //             height: 52.h,
  //             alignmentDirectional: AlignmentDirectional.center,
  //             onPressed: () async {
  //               FocusManager.instance.primaryFocus?.unfocus();
  //
  //               if (!Validators.isNotEmptyString(_commentController.text)) {
  //                 HelperFunction.showToast(
  //                     "${StringLbl.validationMessage} ${StringLbl.comment}");
  //               }
  //               if (!Validators.isNotEmptyString(_passwordController.text)) {
  //                 HelperFunction.showToast(
  //                     "${StringLbl.validationMessage} ${StringLbl.password}");
  //               } else {
  //                 HelperFunction.showToast("all validated");
  //                 sl<AccountBloc>().add(LogInEvent(
  //                     logInParams: LogInParams(
  //                         body: LogInParamsBody(
  //                             comment: _commentController.text,
  //                             password: _passwordController.text))));
  //               }
  //             },
  //           ),
  //         );
  //       });
  // }
}
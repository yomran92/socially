import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/constants.dart';
import '../../../../core/state/appstate.dart';
import '../../../../core/string_lbl.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/utils/helper_function.dart';
import '../../../../core/utils/hive_keys.dart';
import '../../../../core/utils/hive_paramter.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../core/validators/validators.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/empty_state_widget.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../service_locator.dart';
import '../../../commet/data/models/param/add_new_comment_param.dart';
import '../../../commet/data/models/param/get_all_comment_param.dart';
import '../../../commet/presentation/bloc/comment_bloc.dart';


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
  GetAllCommentLoadedState? getAllCommentLoadedState;
  bool _enablePullUp = true;
  int _currentSection = 1;
  final _refreshController = RefreshController();
  late GetAllCommentLoadedState currentState;

  @override
  void dispose() {
    super.dispose();
  }
  void _initComment() {
    _currentSection = 1;
    _enablePullUp = true;
  }
  @override
  void initState() {
    _initComment();
    _requestComment();

    super.initState();
  }

  _requestComment() async {
    sl<CommentBloc>().add(GetAllCommentEvent(
        params: GetAllCommentParams(
            body: GetAllCommentParamsBody(
                limit: Pagelimit, skip: (_currentSection - 1) * Pagelimit))));
  }

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
    return

      BlocConsumer<CommentBloc, CommentState>(
          bloc: sl<CommentBloc>(),
          listener: (context, CommentState state) async {
            if (state is GetAllCommentLoadedState) {
              sl<NetworkInfo>().connectivityNotifier.value =
                  ConnectivityResult.mobile;

              _refreshController.loadComplete();
              _refreshController.refreshCompleted();
              if ((state.total ?? 0) > 0) {
                if (getAllCommentLoadedState == null) {
                  getAllCommentLoadedState = state;
                } else if (_currentSection == 1) {
                  getAllCommentLoadedState = state;
                } else if (_currentSection > 1) {
                  getAllCommentLoadedState!.comments!
                      .addAll(state.comments ?? []);
                }
              } else {
                _enablePullUp = true;
              }
              if (state.total! <= ((_currentSection) * Pagelimit)) {
                _enablePullUp = false;
              }
            }   else if (state is CommentError) {
              HelperFunction.showToast(state.message.toString());
              if (state.message
                  .toString()
                  .compareTo(StringLbl.noInternetConnection) ==
                  0) {
                sl<NetworkInfo>().connectivityNotifier.value =
                    ConnectivityResult.none;
                final taskBox = await sl<HiveParamter>()
                    .hive
                    .box(HiveKeys.taskBox);



                _currentSection = 1;
                _enablePullUp = false;
              }
            }
          },
          builder: (context, state) {
            if (state is CommentLoading && _currentSection == 1)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (state is CommentError && getAllCommentLoadedState == null)
              return ErrorWidgetScreen(
                callBack: () {
                  _requestComment();
                },
                message: state.message,
                height: 250.h,
                width: 250.w,
              );
            return Scrollbar(
                interactive: true,
                radius: const Radius.circular(10),
                child: SmartRefresher(
                    controller: _refreshController,
                    enablePullUp: _enablePullUp,
                    onRefresh: () {
                      _initComment();
                      _requestComment();
                    },
                    onLoading: () {
                      setState(() {
                        _currentSection++;

                        _requestComment();
                      });
                    },
                    child: getAllCommentLoadedState == null
                        ? EmptyStateWidget(
                      text: 'no data found add some task',
                    )
                        : ListView.separated(
                      itemCount:
                      getAllCommentLoadedState!.comments!.length,
                      itemBuilder:
                          (BuildContext context, index) {
                        return  Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: DraggableScrollableSheet(
                            expand: false,
                            builder: (context, scrollController) {
                              return



                                Container(



                                  padding: EdgeInsets.all( CommonSizes.Size_12_HGAP

                                    ,),
                                  decoration: Styles.gradientRoundedDecoration(
                                      radius: 20.r,
                                      alignmentGeometryBegin: Alignment(0, 0),
                                      alignmentGeometryEnd: Alignment(0, 1),
                                      customBorder:BorderRadius.only(topLeft:Radius.circular(20.r) ,topRight:Radius.circular(20.r)  ) ,
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


                              BlocConsumer<CommentBloc, CommentState>(
                              bloc: sl<CommentBloc>(),
                              listener: (context, CommentState state) {
                              if (state is AddNewCommentState) {
                              Navigator.pop<bool>(context, true);
                              } else if (state is CommentError) {
                              HelperFunction.showToast(state.message);

                              Navigator.pop<bool>(context, false);
                              }
                              },
                              builder: (context, state) {
                              if (state is CommentLoading)
                              return Center(
                              child: CircularProgressIndicator(),
                              );
                              if (state is CommentError)
                              return ErrorWidgetScreen(
                              callBack: () {
                              if (!Validators.isNotEmptyString(_commentController.text)) {
                              HelperFunction.showToast(
                              '${StringLbl.validationMessage} ${StringLbl.todo} ');
                              } else {
                              HelperFunction.showToast("all validated");


                                  sl<CommentBloc>().add(AddNewCommentEvent(
                                addCommentParams: AddCommentParams(
                                    body: AddCommentParamsBody(
                                        todo: _commentController.text,
                                        completed: true,
                                        userId: sl<AppStateModel>().user!.id)), ));
                              }
                              },
                              message: state.message,
                              height: 250.h,
                              width: 250.w,
                              );

                              return
InkWell( child:
                                IconButton(
                                  icon: Icon(Icons.send, color: Styles.colorTextWhite),


                              onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();

                              if (!Validators.isNotEmptyString(_commentController.text)) {
                              HelperFunction.showToast(
                              '${StringLbl.validationMessage} ${StringLbl.todo} ');
                              } else {
                              HelperFunction.showToast("all validated");

                              sl<CommentBloc>().add(AddNewCommentEvent(
                                  addCommentParams: AddCommentParams(
                              body: AddCommentParamsBody(
                              todo: _commentController.text,
                              completed: true,
                              userId: sl<AppStateModel>().user!.id)), ));
                              }
                              }),
                              );
                              })


                                              // onPressed: () {
                                              //   if (_commentController.text.isNotEmpty) {
                                              //     _addNewComment(_commentController.text);
                                              //   }
                                              // },
                                              ]),
                                      CommonSizes.vSmallestSpace
                                    ],
                                  ),
                                );
                            },
                          ),
                        );
                          },
                      separatorBuilder:
                          (BuildContext context, int index) =>
                      CommonSizes.vSmallerSpace,
                    )));
            return Container();
          })

      ;
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

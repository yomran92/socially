
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todoapp/core/assets_path.dart';
import 'package:todoapp/core/state/appstate.dart';
import 'package:todoapp/core/string_lbl.dart';
import 'package:todoapp/core/utils/common_sizes.dart';
import 'package:todoapp/core/utils/network_info.dart';
import 'package:todoapp/core/widget/custom_button.dart';
import 'package:todoapp/core/widget/custom_rich_text.dart';
import 'package:todoapp/core/widget/custom_svg_picture.dart';
import 'package:todoapp/core/widget/empty_state_widget.dart';
import 'package:todoapp/features/task/data/models/param/get_all_task_param.dart';
import 'package:todoapp/features/task/domain/entities/get_all_task_entity.dart';
import 'package:todoapp/features/task/domain/entities/get_task_entity.dart';
import 'package:todoapp/service_locator.dart';

import '../../../../core/constants.dart';
import '../../../../core/styles.dart';
import '../../../../core/utils/helper_function.dart';
import '../../../../core/utils/hive_keys.dart';
import '../../../../core/utils/hive_paramter.dart';
import '../../../../core/widget/custom_button_with_icon.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/social_app_bar.dart';
import '../../../task/presentation/bloc/task_bloc.dart';

import '../components/comment_widget.dart';
import '../components/story_widget.dart';
import '../components/task_widget.dart';

const String progressIndicatorKey = "PROGRESS INDICATOR KEY";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetAllTaskLoadedState? getAllTaskLoadedState;
  bool _enablePullUp = true;
  int _currentSection = 1;
  final _refreshController = RefreshController();
  late GetAllTaskLoadedState currentState;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _initTasks();
    _requestTask();

    super.initState();
  }

  _requestTask() async {
    sl<TaskBloc>().add(GetAllTaskEvent(
        params: GetAllTaskParams(
            body: GetAllTaskParamsBody(
                limit: Pagelimit, skip: (_currentSection - 1) * Pagelimit))));
  }

  void _initTasks() {
    _currentSection = 1;
    _enablePullUp = true;
  }
  ValueNotifier<bool> showComment = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {

    return Scaffold(


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

                    Container(
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
                         CustomRichText(text: [
                          new TextSpan(
                              text:'Kylie Jenner ',
                              style:  Styles.w500TextStyle().copyWith(fontSize: 16.sp)),
                     new TextSpan(
                              text:'.With Zoe Sugg ',
                              style:  Styles.w500TextStyle().copyWith(fontSize: 15.sp)),
                  
                  
                        ], )),
                        CustomText(text: '2 d ago', style:
                      Styles.w500TextStyle().copyWith(fontSize: 14.sp,


                          color: Styles.colorTextInactive.withOpacity(0.6))),
                  
                  
                             ],)),
CommonSizes.vSmallestSpace,
                      CustomRichText(
                        text: [],
                  
                        textWithemogi:
                        """Stopped by @zoesugg today with goosey girl to see @kyliecosmetics & @kylieskin 💕 wow what a dream!!!!!!!!
                  It’s the best experience we have!""",
                        withtextWithemogi: true,
                  
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
                          CustomText(text: '12535',
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
                               builder: (context) => CommentBottomSheet(),
                             );
                           },

                           child:   CustomPicture(path: AssetsPath.SVGComment,isSVG: true,
                          height: 25.r,
                          width: 25.r,)),
                          CustomText(text: '12535',
                            isNumberFormat: true,
                            style:  Styles.w500TextStyle().copyWith(fontSize: 14.sp,color: Styles.colorTextTitle)

                            ,),
                        Spacer(),
                        CustomPicture(path: AssetsPath.SVGShare,isSVG: true,
                          height: 25.r,
                          width: 25.r,),
                      ],)),
                  

                  
                    ],),
                  ),
                    CommonSizes.vSmallerSpace,
                    Container(
                      margin:  EdgeInsets.only(

                        left: CommonSizes.Size_12_HGAP,
                        right: CommonSizes.Size_12_HGAP,),
                      padding: EdgeInsets.all(CommonSizes.Size_12_HGAP,),
                      decoration: Styles.coloredRoundedDecoration(radius:20.r ),
                      child:
                      Column(children: [
                        Container(
                            height: 25,
                            width: 376.w,child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomPicture(path: AssetsPath.PNGPerson,
                                height: 25.r, width:25.r),
                            Expanded(child:
                            CustomRichText(text: [
                              new TextSpan(
                                  text:'Kylie Jenner ',
                                  style:  Styles.w500TextStyle().copyWith(fontSize: 16.sp)),
                              new TextSpan(
                                  text:'.With Zoe Sugg ',
                                  style:  Styles.w500TextStyle().copyWith(fontSize: 15.sp)),


                            ], )),
                            CustomText(text: '2 d ago', style:
                            Styles.w500TextStyle().copyWith(fontSize: 14.sp,


                                color: Styles.colorTextInactive.withOpacity(0.6))),


                          ],)),
                        CommonSizes.vSmallestSpace,
                   CustomPicture(path: AssetsPath.SVGNAVBarProfile,isSVG: true,
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
                              CustomText(text: '12535',
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
                                      builder: (context) => CommentBottomSheet(),
                                    );
                                  },

                                  child:   CustomPicture(path: AssetsPath.SVGComment,isSVG: true,
                                    height: 25.r,
                                    width: 25.r,)),
                              CustomText(text: '12535',
                                isNumberFormat: true,
                                style:  Styles.w500TextStyle().copyWith(fontSize: 14.sp,color: Styles.colorTextTitle)

                                ,),
                              Spacer(),
                              CustomPicture(path: AssetsPath.SVGShare,isSVG: true,
                                height: 25.r,
                                width: 25.r,),
                            ],)),


                    ],),
                  ),
                    Container(
                      margin:  EdgeInsets.only(

                        left: CommonSizes.Size_12_HGAP,
                        right: CommonSizes.Size_12_HGAP,),
                      padding: EdgeInsets.all(CommonSizes.Size_12_HGAP,),
                      decoration: Styles.coloredRoundedDecoration(radius:20.r ),
                      child:
                      Column(children: [
                        Container(
                            height: 25,
                            width: 376.w,child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomPicture(path: AssetsPath.PNGPerson,
                                height: 25.r, width:25.r),
                            Expanded(child:
                            CustomRichText(text: [
                              new TextSpan(
                                  text:'Kylie Jenner ',
                                  style:  Styles.w500TextStyle().copyWith(fontSize: 16.sp)),
                              new TextSpan(
                                  text:'.With Zoe Sugg ',
                                  style:  Styles.w500TextStyle().copyWith(fontSize: 15.sp)),


                            ], )),
                            CustomText(text: '2 d ago', style:
                            Styles.w500TextStyle().copyWith(fontSize: 14.sp,


                                color: Styles.colorTextInactive.withOpacity(0.6))),


                          ],)),
                        CommonSizes.vSmallestSpace,
                   CustomPicture(path: AssetsPath.SVGNAVBarProfile,isSVG: true,
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
                              CustomText(text: '12535',
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
                                      builder: (context) => CommentBottomSheet(),
                                    );
                                  },

                                  child:   CustomPicture(path: AssetsPath.SVGComment,isSVG: true,
                                    height: 25.r,
                                    width: 25.r,)),
                              CustomText(text: '12535',
                                isNumberFormat: true,
                                style:  Styles.w500TextStyle().copyWith(fontSize: 14.sp,color: Styles.colorTextTitle)

                                ,),
                              Spacer(),
                              CustomPicture(path: AssetsPath.SVGShare,isSVG: true,
                                height: 25.r,
                                width: 25.r,),
                            ],)),


                    ],),
                  ),
                  // BlocConsumer<TaskBloc, TaskState>(
                  //     bloc: sl<TaskBloc>(),
                  //     listener: (context, TaskState state) async {
                  //       if (state is GetAllTaskLoadedState) {
                  //         sl<NetworkInfo>().connectivityNotifier.value =
                  //             ConnectivityResult.mobile;
                  //
                  //         _refreshController.loadComplete();
                  //         _refreshController.refreshCompleted();
                  //         if ((state.total ?? 0) > 0) {
                  //           if (getAllTaskLoadedState == null) {
                  //             getAllTaskLoadedState = state;
                  //           } else if (_currentSection == 1) {
                  //             getAllTaskLoadedState = state;
                  //           } else if (_currentSection > 1) {
                  //             getAllTaskLoadedState!.tasks!
                  //                 .addAll(state.tasks ?? []);
                  //           }
                  //         } else {
                  //           _enablePullUp = true;
                  //         }
                  //         if (state.total! <= ((_currentSection) * Pagelimit)) {
                  //           _enablePullUp = false;
                  //         }
                  //       }  else if (state is UpdateTaskState) {
                  //         sl<NetworkInfo>().connectivityNotifier.value =
                  //             ConnectivityResult.mobile;
                  //         int index = -1;
                  //         index = getAllTaskLoadedState!.tasks!.indexWhere(
                  //                 (element) => element.id == state.taskModel!.id);
                  //
                  //         if (index == -1) {
                  //           _initTasks();
                  //           _requestTask();
                  //         } else {
                  //           getAllTaskLoadedState!.tasks![index].completed =
                  //               state.taskModel.completed;
                  //         }
                  //       } else if (state is TaskError) {
                  //         HelperFunction.showToast(state.message.toString());
                  //         if (state.message
                  //             .toString()
                  //             .compareTo(StringLbl.noInternetConnection) ==
                  //             0) {
                  //           sl<NetworkInfo>().connectivityNotifier.value =
                  //               ConnectivityResult.none;
                  //           final taskBox = await sl<HiveParamter>()
                  //               .hive
                  //               .box(HiveKeys.taskBox);
                  //
                  //
                  //
                  //           _currentSection = 1;
                  //           _enablePullUp = false;
                  //         }
                  //       } else if (state is DeleteTaskState) {
                  //         sl<NetworkInfo>().connectivityNotifier.value =
                  //             ConnectivityResult.mobile;
                  //         getAllTaskLoadedState!.tasks!.removeWhere(
                  //                 (element) => state.taskModel.id == element.id);
                  //         getAllTaskLoadedState!.total !=
                  //             getAllTaskLoadedState!.total! - 1;
                  //         HelperFunction.showToast('Deleted Successfully ');
                  //       }
                  //     },
                  //     builder: (context, state) {
                  //       if (state is TaskLoading && _currentSection == 1)
                  //         return Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       if (state is TaskError && getAllTaskLoadedState == null)
                  //         return ErrorWidgetScreen(
                  //           callBack: () {
                  //             _requestTask();
                  //           },
                  //           message: state.message,
                  //           height: 250.h,
                  //           width: 250.w,
                  //         );
                  //       return Scrollbar(
                  //           interactive: true,
                  //           radius: const Radius.circular(10),
                  //           child: SmartRefresher(
                  //               controller: _refreshController,
                  //               enablePullUp: _enablePullUp,
                  //               onRefresh: () {
                  //                 _initTasks();
                  //                 _requestTask();
                  //               },
                  //               onLoading: () {
                  //                 setState(() {
                  //                   _currentSection++;
                  //
                  //                   _requestTask();
                  //                 });
                  //               },
                  //               child: getAllTaskLoadedState == null
                  //                   ? EmptyStateWidget(
                  //                 text: 'no data found add some task',
                  //               )
                  //                   : ListView.separated(
                  //                 itemCount:
                  //                 getAllTaskLoadedState!.tasks!.length,
                  //                 itemBuilder:
                  //                     (BuildContext context, index) {
                  //                   return TaskWidget(
                  //                     allowEdite: sl<NetworkInfo>()
                  //                         .connectivityNotifier
                  //                         .value !=
                  //                         ConnectivityResult.none,
                  //                     task: getAllTaskLoadedState!
                  //                         .tasks![index],
                  //                   );
                  //                 },
                  //                 separatorBuilder:
                  //                     (BuildContext context, int index) =>
                  //                 CommonSizes.vSmallerSpace,
                  //               )));
                  //       return Container();
                  //     })
                  ],),
                )

            ));
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todoapp/core/assets_path.dart';
import 'package:todoapp/core/styles.dart';
import 'package:todoapp/core/widget/custom_svg_picture.dart';
import 'package:todoapp/features/home/presentation/screens/story_view_widget.dart';

import '../../../../core/constants.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/string_lbl.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/utils/helper_function.dart';
import '../../../../core/utils/hive_keys.dart';
import '../../../../core/utils/hive_paramter.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../core/widget/empty_state_widget.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../service_locator.dart';
import '../../data/models/param/get_all_story_param.dart';
import '../bloc/story/story_bloc.dart';


class StoryWidget extends StatefulWidget {

    StoryWidget({Key? key, })
      : super(key: key);

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  GetAllStoryLoadedState? getAllStoryLoadedState;

  bool _enablePullUp = true;

  int _currentSection = 1;

  final _refreshController = RefreshController();

  late GetAllStoryLoadedState currentState;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _initStory();
    _requestStory();

    super.initState();
  }
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
       Styles.colorStoryGradientStart,
       Styles.colorStoryGradientEnd
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



BlocConsumer<StoryBloc,StoryState>(
    bloc: sl<StoryBloc>(),
    listener: (context, StoryState state) async {
      if (state is GetAllStoryLoadedState) {
        sl<NetworkInfo>().connectivityNotifier.value =
            ConnectivityResult.mobile;

        _refreshController.loadComplete();
        _refreshController.refreshCompleted();
        if ((state.total ?? 0) > 0) {
          if (getAllStoryLoadedState == null) {
            getAllStoryLoadedState = state;
          } else if (_currentSection == 1) {
            getAllStoryLoadedState = state;
          } else if (_currentSection > 1) {
            getAllStoryLoadedState!.tasks!
                .addAll(state.tasks ?? []);
          }
        } else {
          _enablePullUp = true;
        }
        if (state.total! <= ((_currentSection) * Pagelimit)) {
          _enablePullUp = false;
        }
      }    else if (state is StoryError) {
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
      if (state is StoryLoading && _currentSection == 1)
        return Center(
          child: CircularProgressIndicator(),
        );
      if (state is StoryError && getAllStoryLoadedState == null)
        return ErrorWidgetScreen(
          callBack: () {
            _requestStory();
          },
          message: state.message,
          height: 52.h,
        );
      return Scrollbar(
          interactive: true,
          radius: const Radius.circular(10),
          child: SmartRefresher(
              controller: _refreshController,
              enablePullUp: _enablePullUp,
              onRefresh: () {
                _initStory();
                _requestStory();
              },
              onLoading: () {
                setState(() {
                  _currentSection++;

                  _requestStory();
                });
              },
              child: getAllStoryLoadedState  == null
                  ? EmptyStateWidget(
                text: 'no data found add some task',
              )
                  : ListView.separated(

                padding: EdgeInsets.only(left: 8.h),

                scrollDirection: Axis.horizontal,

                shrinkWrap: true,
                itemCount:
                getAllStoryLoadedState!.tasks!.length,
                itemBuilder:
                    (BuildContext context, index) {
                  return GestureDetector(onTap: (){
                    final List<String> storyImages = [
                      'https://via.placeholder.com/400x700/FF0000/FFFFFF?text=Story+1',

                    ];
                    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                      context,
                      settings: RouteSettings(name:     RoutePaths.stroyViewPage,
                      ),
                      screen: StoryViewer(images: storyImages, initialIndex: 1),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );



                  },child:
                      CustomPicture(path: AssetsPath.PNGPerson,
                      height: 56.h,
                      isCircleShape: true,
                      isSVG: false,
                      withBorder: true,
                      width: 56.h ));
                },

                separatorBuilder: (context,index)=>CommonSizes.hSmallerSpace,

              )));
      return Container();
    })


//
// ListView.separated(
// padding: EdgeInsets.only(left: 8.h),
//      separatorBuilder: (context,index)=>CommonSizes.hSmallerSpace,
//        itemCount: 20,
//
//   scrollDirection: Axis.horizontal,
//
//   shrinkWrap: true,
//    itemBuilder:
// (context, index) =>
// GestureDetector(onTap: (){
//   final List<String> storyImages = [
//     'https://via.placeholder.com/400x700/FF0000/FFFFFF?text=Story+1',
//
//   ];
//   PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
//     context,
//     settings: RouteSettings(name:     RoutePaths.stroyViewPage,
//     ),
//     screen: StoryViewer(images: storyImages, initialIndex: 1),
//     withNavBar: false,
//     pageTransitionAnimation: PageTransitionAnimation.cupertino,
//   );
//
//
//
// },child:
//      CustomPicture(path: AssetsPath.PNGPerson,
//     height: 56.h,
// isCircleShape: true,
//     isSVG: false,
//     withBorder: true,
//     width: 56.h ),
// )),
)  ) );
  }

  _requestStory() async {
    sl<StoryBloc>().add(GetAllStoryEvent(
        params: GetAllStoryParams(
            body: GetAllStoryParamsBody(
                limit: Pagelimit, skip: (_currentSection - 1) * Pagelimit))));
  }

  void _initStory() {
    _currentSection = 1;
    _enablePullUp = true;
  }
}

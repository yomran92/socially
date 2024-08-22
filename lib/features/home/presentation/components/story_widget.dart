import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socially/core/styles.dart';
import 'package:socially/core/widget/custom_svg_picture.dart';
import 'package:socially/core/widget/waiting_widget.dart';
import 'package:socially/features/home/presentation/screens/story_view_widget.dart';

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
import '../../data/models/get_all_story_model.dart';
import '../../data/models/param/get_all_story_param.dart';
import '../../domain/entities/get_all_story_entity.dart';
import '../bloc/story/story_bloc.dart';

class StoryWidget extends StatefulWidget {
  StoryWidget({
    Key? key,
  }) : super(key: key);

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
        margin: EdgeInsets.only(
          left: CommonSizes.Size_24_HGAP,
          right: CommonSizes.Size_24_HGAP,
        ),
        padding: EdgeInsets.only(
          top: CommonSizes.Size_8_HGAP,
          bottom: CommonSizes.Size_8_HGAP,
        ),
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
                color: Styles.colorShadow.withOpacity(0.1),
                spreadRadius: 0,
                offset: Offset(0, 2),
                blurRadius: 9,
              ),
            ]),
        child: Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(48.r),
                child: BlocConsumer<StoryBloc, StoryState>(
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
                            getAllStoryLoadedState!.storys!
                                .addAll(state.storys ?? []);
                          }
                        } else {
                          _enablePullUp = true;
                        }
                        if (state.total! <= ((_currentSection) * Pagelimit)) {
                          _enablePullUp = false;
                        }
                      } else if (state is StoryError) {
                        HelperFunction.showToast(state.message.toString());
                        if (state.message
                                .toString()
                                .compareTo(StringLbl.noInternetConnection) ==
                            0) {
                          sl<NetworkInfo>().connectivityNotifier.value =
                              ConnectivityResult.none;
                          final storyBox = await sl<HiveParamter>()
                              .hive
                              .box(HiveKeys.storyBox);
                          GetAllStoryEntity getAllStoryEntity =
                              (storyBox.get(HiveKeys.storyListKey)
                                      as GetAllStoryModel)
                                  .toEntity();

                          getAllStoryLoadedState = GetAllStoryLoadedState(
                              storys: getAllStoryEntity.storys,
                              limit: getAllStoryEntity.limit,
                              total: getAllStoryEntity.total,
                              skip: getAllStoryEntity.skip);
                          _currentSection = 1;
                          _enablePullUp = false;
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is StoryLoading && _currentSection == 1)
                        return WaitingWidget(
                          isStory: true,
                        );
                      if (state is StoryError && getAllStoryLoadedState == null)
                        return ErrorWidgetScreen(
                          callBack: () {
                            _requestStory();
                          },
                          message: state.message,
                          height: 52.h,
                          isHorizontal: true,
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
                              child: getAllStoryLoadedState == null
                                  ? EmptyStateWidget(
                                      text: StringLbl.noDataFound,
                                    )
                                  : ListView.separated(
                                      padding: EdgeInsets.only(left: 8.h),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: getAllStoryLoadedState!
                                          .storys!.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              PersistentNavBarNavigator
                                                  .pushNewScreenWithRouteSettings(
                                                context,
                                                settings: RouteSettings(
                                                  name:
                                                      RoutePaths.stroyViewPage,
                                                ),
                                                screen: StoryViewer(
                                                  story: getAllStoryLoadedState!
                                                      .storys![index],
                                                ),
                                                withNavBar: false,
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .cupertino,
                                              );
                                            },
                                            child: CustomPicture(
                                                path: getAllStoryLoadedState!
                                                        .storys?[index].image ??
                                                    '',
                                                height: 56.h,
                                                borderColor:
                                                    Styles.colorTextWhite,
                                                isCircleShape: true,
                                                isSVG: false,
                                                withBorder: true,
                                                width: 56.h));
                                      },
                                      separatorBuilder: (context, index) =>
                                          CommonSizes.hSmallerSpace,
                                    )));
                      return Container();
                    }))));
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

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socially/features/post/presentation/screen/post_card.dart';

import '../../../../core/constants.dart';
import '../../../../core/string_lbl.dart';
import '../../../../core/utils/common_sizes.dart';
import '../../../../core/utils/helper_function.dart';
import '../../../../core/utils/hive_keys.dart';
import '../../../../core/utils/hive_paramter.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../core/widget/empty_state_widget.dart';
import '../../../../core/widget/error_widget.dart';
import '../../../../core/widget/waiting_widget.dart';
import '../../../../service_locator.dart';
import '../../data/models/get_all_post_model.dart';
import '../../data/models/param/get_all_post_param.dart';
import '../../domain/entities/get_all_Post_entity.dart';
import '../bloc/post_bloc.dart';

class PostListWidget extends StatefulWidget {
  const PostListWidget({super.key});

  @override
  State<PostListWidget> createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget> {
  GetAllPostLoadedState? getAllPostLoadedState;
  bool _enablePullUp = true;
  int _currentSection = 1;
  final _refreshController = RefreshController();
  late GetAllPostLoadedState currentState;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _initPost();
    _requestPost();

    super.initState();
  }

  _requestPost() async {
    sl<PostBloc>().add(GetAllPostEvent(
        params: GetAllPostParams(
            body: GetAllPostParamsBody(
                limit: Pagelimit, skip: (_currentSection - 1) * Pagelimit))));
  }

  void _initPost() {
    _currentSection = 1;
    _enablePullUp = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<PostBloc, PostState>(
          bloc: sl<PostBloc>(),
          listener: (context, PostState state) async {
            if (state is GetAllPostLoadedState) {
              sl<NetworkInfo>().connectivityNotifier.value =
                  ConnectivityResult.mobile;

              _refreshController.loadComplete();
              _refreshController.refreshCompleted();
              if ((state.total ?? 0) > 0) {
                if (getAllPostLoadedState == null) {
                  getAllPostLoadedState = state;
                } else if (_currentSection == 1) {
                  getAllPostLoadedState = state;
                } else if (_currentSection > 1) {
                  getAllPostLoadedState!.post!.addAll(state.post ?? []);
                }
              } else {
                _enablePullUp = true;
              }
              if (state.total! <= ((_currentSection) * Pagelimit)) {
                _enablePullUp = false;
              }
            } else if (state is PostError) {
              HelperFunction.showToast(state.message.toString());
              if (state.message
                      .toString()
                      .compareTo(StringLbl.noInternetConnection) ==
                  0) {
                sl<NetworkInfo>().connectivityNotifier.value =
                    ConnectivityResult.none;




                final postBox =
                    await sl<HiveParamter>().hive.box(HiveKeys.postBox);
                GetAllPostEntity getAllPostEntity =
                    (postBox.get(HiveKeys.postListKey) as GetAllPostModel)
                        .toEntity();
                 getAllPostLoadedState = GetAllPostLoadedState(
                    post: getAllPostEntity.posts,
                    limit: getAllPostEntity.limit,
                    total: getAllPostEntity.total,
                    skip: getAllPostEntity.skip);

                _currentSection = 1;
                _enablePullUp = false;
              }
            }
          },
          builder: (context, state) {
            if (state is PostLoading && _currentSection == 1)
              return WaitingWidget(
                isStory: false,
              );
            if (state is PostError && getAllPostLoadedState == null)
              return ErrorWidgetScreen(
                callBack: () {
                  _requestPost();
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
                      _initPost();
                      _requestPost();
                    },
                    onLoading: () {
                      setState(() {
                        _currentSection++;

                        _requestPost();
                      });
                    },
                    child: getAllPostLoadedState == null
                        ? EmptyStateWidget(
                            text: 'no data found add some task',
                          )
                        : ListView.separated(
                            itemCount: getAllPostLoadedState!.post!.length,
                            itemBuilder: (BuildContext context, index) {
                              return PostCard(
                                  postEntity:
                                      getAllPostLoadedState!.post![index],
                                  isImage: index % 2 == 0);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    CommonSizes.vSmallerSpace,
                          )));
            return Container();
          }),
    );
  }
}

import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:socially/core/state/appstate.dart';
import 'package:socially/core/utils/hive_paramter.dart';
import 'package:socially/features/account/data/remote/data_sources/account_remote_data_source.dart';
import 'package:socially/features/account/data/remote/models/responses/user_model.dart';
import 'package:socially/features/account/data/repositories/account_repository.dart';
import 'package:socially/features/commet/data/models/comment_model.dart';
import 'package:socially/features/post/presentation/bloc/post_bloc.dart';

import 'core/utils/network_info.dart';
import 'features/account/domain/use_cases/login_use_case.dart';
import 'features/account/presentation/blocs/account_bloc.dart';
import 'features/commet/data/data_sources/remote/remote_data_source.dart';
import 'features/commet/data/models/get_all_comment_model.dart';
import 'features/commet/data/repositories/default_comment_repository.dart';
import 'features/commet/domain/repositories/comment_repository.dart';
import 'features/commet/presentation/bloc/comment_bloc.dart';
import 'features/home/data/data_sources/remote/remote_data_source.dart';
import 'features/home/data/models/get_all_story_model.dart';
import 'features/home/data/models/story_model.dart';
import 'features/home/data/repositories/default_story_repository.dart';
import 'features/home/domain/repositories/story_repository.dart';
import 'features/home/presentation/bloc/story/story_bloc.dart';
import 'features/post/data/data_sources/remote/remote_data_source.dart';
import 'features/post/data/models/get_all_post_model.dart';
import 'features/post/data/models/post_model.dart';
import 'features/post/data/repositories/default_post_repository.dart';
import 'features/post/domain/repositories/Post_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();

  // DB
  sl.registerLazySingleton<HiveInterface>(() {
    final HiveInterface hive = Hive;

    hive.init(directory.path);
    hive.registerAdapter<UserModel>(UserModelAdapter());
    hive.registerAdapter<PostModel>(PostModelAdapter());
    hive.registerAdapter<CommentModel>(CommentModelAdapter());
    hive.registerAdapter<StoryModel>(StoryModelAdapter());
    hive.registerAdapter<GetAllPostModel>(GetAllPostModelAdapter());
    hive.registerAdapter<GetAllCommentModel>(GetAllCommentModelAdapter());
    hive.registerAdapter<GetAllStoryModel>(GetAllStoryModelAdapter());

    return hive;
  });

  sl.registerFactory(() => HiveParamter(path: directory.path, hive: sl()));
  sl.registerLazySingleton(() => StoryBloc());
  sl.registerLazySingleton(() => AccountBloc());
  sl.registerLazySingleton(() => PostBloc());
  sl.registerLazySingleton(() => CommentBloc());

  sl.registerLazySingleton(() => NetworkInfo());
  sl.registerLazySingleton(() => AppStateModel());

  // Data sources
  sl.registerLazySingleton(() => PostRemoteDataSource(
        sl(),
      ));
  sl.registerLazySingleton(() => StoryRemoteDataSource(
        sl(),
      ));
  sl.registerLazySingleton(() => CommentRemoteDataSource(
        sl(),
      ));
  sl.registerLazySingleton(() => AccountRemoteDataSource(sl()));

  // Repositories
  sl.registerLazySingleton<StoryRepository>(() => DefaultStoryRepository(sl()));
  sl.registerLazySingleton<PostRepository>(() => DefaultPostRepository(sl()));
  sl.registerLazySingleton<CommentRepository>(
      () => DefaultCommentRepository(sl()));
  sl.registerLazySingleton(() => AccountRepository(sl()));

  // Usecases

  sl.registerLazySingleton(() => LogInUseCase(sl()));
}

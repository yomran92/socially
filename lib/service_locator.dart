import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:todoapp/core/state/appstate.dart';
import 'package:todoapp/core/utils/hive_paramter.dart';


import 'core/utils/network_info.dart';
import 'features/home/data/data_sources/remote/remote_data_source.dart';
import 'features/home/data/repositories/default_story_repository.dart';
import 'features/home/domain/repositories/story_repository.dart';
import 'features/home/presentation/bloc/story/story_bloc.dart';
import 'features/post/data/data_sources/remote/remote_data_source.dart';
import 'features/post/data/repositories/default_post_repository.dart';
import 'features/post/domain/repositories/Post_repository.dart';
import 'features/post/presentation/bloc/post_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();

  // DB
  sl.registerLazySingleton<HiveInterface>(() {
    final HiveInterface hive = Hive;

    hive.init(directory.path);


    return hive;
  });

  sl.registerFactory(() => HiveParamter(path: directory.path, hive: sl()));
   sl.registerLazySingleton(() => StoryBloc());
  sl.registerLazySingleton(() => PostBloc());

  sl.registerLazySingleton(() => NetworkInfo());
  sl.registerLazySingleton(() => AppStateModel());
  sl.registerLazySingleton(() =>PostRemoteDataSource(
    sl(),
  ));
  sl.registerLazySingleton<PostRepository>(() => DefaultPostRepository(sl()));

  // Data sources

      sl.registerLazySingleton(() => StoryRemoteDataSource(
        sl(),
      ));
  sl.registerLazySingleton(() =>PostRemoteDataSource(
    sl(),
  ));

  // Repositories
   sl.registerLazySingleton<StoryRepository>(() => DefaultStoryRepository(sl()));



}

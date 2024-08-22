import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:todoapp/features/task/data/models/param/delete_task_param.dart';

import '../../../../core/error/app_exceptions.dart';
import '../../../../core/error/error_entity.dart';
import '../../../../core/utils/hive_keys.dart';
import '../../../../core/utils/hive_paramter.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/get_all_story_entity.dart';
import '../../domain/repositories/story_repository.dart';
import '../data_sources/remote/remote_data_source.dart';
import '../models/get_all_story_model.dart';
import '../models/param/get_all_story_param.dart';


class DefaultStoryRepository implements StoryRepository {
  final StoryRemoteDataSource? remoteDataSource;

  DefaultStoryRepository(this.remoteDataSource);

  @override
  Future<Either<ErrorEntity, GetAllStoryEntity>> getAllStory(
      GetAllStoryParams params) async {
    try {
//check connection
      bool isConnected = sl<NetworkInfo>().connectivityNotifier.value !=
          ConnectivityResult.none;
      final storyData;
      storyData = await remoteDataSource!.getAllStory(params);
      final taskBox = await sl<HiveParamter>().hive.box(HiveKeys.taskBox);

      GetAllStoryModel? getAllStoryModelLocal = taskBox.get(HiveKeys.taskListKey);
      if (getAllStoryModelLocal == null) {
        getAllStoryModelLocal =
            GetAllStoryModel(skip: 0, total: 0, limit: 0, todos: []);
      }
      GetAllStoryModel getAllStoryModel = storyData as GetAllStoryModel;
      getAllStoryModelLocal.todos!.addAll(getAllStoryModel.todos ?? []);
      getAllStoryModelLocal.todos!.toSet().toList();
      taskBox.put(HiveKeys.taskListKey, storyData );

      return Right(getAllStoryModel.toEntity());
    } on AppException catch (e) {
      return Left(ErrorEntity.fromException(e));
    }
  }



}

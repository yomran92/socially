import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

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
      final taskBox = await sl<HiveParamter>().hive.box(HiveKeys.storyBox);

      GetAllStoryModel? getAllStoryModelLocal =
          taskBox.get(HiveKeys.storyListKey);
      if (getAllStoryModelLocal == null) {
        getAllStoryModelLocal =
            GetAllStoryModel(skip: 0, total: 0, limit: 0, storys: []);
      }
      GetAllStoryModel getAllStoryModel = storyData as GetAllStoryModel;
      getAllStoryModelLocal.storys!.addAll(getAllStoryModel.storys ?? []);
      getAllStoryModelLocal.storys!.toSet().toList();
      taskBox.put(HiveKeys.storyListKey, storyData);

      return Right(getAllStoryModel.toEntity());
    } on AppException catch (e) {
      return Left(ErrorEntity.fromException(e));
    }
  }
}

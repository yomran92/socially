import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/models/param/get_all_story_param.dart';
import '../entities/get_all_story_entity.dart';

abstract class StoryRepository {
  Future<Either<ErrorEntity, GetAllStoryEntity>> getAllStory(
      GetAllStoryParams params);
}

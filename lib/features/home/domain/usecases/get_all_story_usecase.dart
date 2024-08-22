import 'package:dartz/dartz.dart';
import 'package:socially/core/usecase/usecase.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/models/param/get_all_story_param.dart';
import '../entities/get_all_story_entity.dart';
import '../repositories/story_repository.dart';

class GetAllStoryUsecase
    implements Usecase<GetAllStoryEntity, GetAllStoryParams> {
  final StoryRepository? storyRepository;

  GetAllStoryUsecase(this.storyRepository);

  @override
  Future<Either<ErrorEntity, GetAllStoryEntity>> call(
      GetAllStoryParams params) async {
    return await storyRepository!.getAllStory(params);
  }
}

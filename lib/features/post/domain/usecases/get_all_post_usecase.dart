import 'package:dartz/dartz.dart';
import 'package:socially/core/usecase/usecase.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/models/param/get_all_post_param.dart';
import '../entities/get_all_Post_entity.dart';
import '../repositories/Post_repository.dart';

class GetAllPostUsecase implements Usecase<GetAllPostEntity, GetAllPostParams> {
  final PostRepository? postRepository;

  GetAllPostUsecase(this.postRepository);

  @override
  Future<Either<ErrorEntity, GetAllPostEntity>> call(
      GetAllPostParams params) async {
    return await postRepository!.getAllPost(params);
  }
}

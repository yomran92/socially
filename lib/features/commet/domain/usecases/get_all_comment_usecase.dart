import 'package:dartz/dartz.dart';
import 'package:todoapp/core/usecase/usecase.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/models/param/get_all_comment_param.dart';
import '../entities/get_all_comment_entity.dart';
import '../repositories/comment_repository.dart';


class GetAllCommentUsecase implements Usecase<GetAllCommentEntity, GetAllCommentParams> {
  final CommentRepository? commentRepository;

  GetAllCommentUsecase(this.commentRepository);

  @override
  Future<Either<ErrorEntity, GetAllCommentEntity>> call(
      GetAllCommentParams params) async {
    return await commentRepository!.getAllComment(params);
  }
}

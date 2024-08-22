import 'package:dartz/dartz.dart';
import 'package:socially/core/usecase/usecase.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/models/param/add_new_comment_param.dart';
import '../entities/get_comment_entity.dart';
import '../repositories/comment_repository.dart';

class AddNewCommentUsecase
    implements Usecase<GetCommentEntity, AddCommentParams> {
  final CommentRepository? commentRepository;

  AddNewCommentUsecase(this.commentRepository);

  @override
  Future<Either<ErrorEntity, GetCommentEntity>> call(
      AddCommentParams params) async {
    return await commentRepository!.addNewComment(params);
  }
}

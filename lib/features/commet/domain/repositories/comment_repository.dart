import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/models/param/add_new_comment_param.dart';
import '../../data/models/param/get_all_comment_param.dart';
import '../entities/get_all_comment_entity.dart';
import '../entities/get_comment_entity.dart';

abstract class CommentRepository {
  Future<Either<ErrorEntity, GetAllCommentEntity>> getAllComment(
      GetAllCommentParams params);

  Future<Either<ErrorEntity, GetCommentEntity>> addNewComment(
      AddCommentParams commentParams);
}

import 'package:dartz/dartz.dart';

import '../../../../core/error/error_entity.dart';
import '../../data/models/param/get_all_post_param.dart';
import '../entities/get_all_Post_entity.dart';


abstract class PostRepository {
  Future<Either<ErrorEntity, GetAllPostEntity>> getAllPost(
      GetAllPostParams params);

}

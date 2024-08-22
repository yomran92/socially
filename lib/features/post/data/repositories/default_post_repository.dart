import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/app_exceptions.dart';
import '../../../../core/error/error_entity.dart';
import '../../../../core/utils/hive_keys.dart';
import '../../../../core/utils/hive_paramter.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/get_all_Post_entity.dart';
import '../../domain/repositories/Post_repository.dart';
import '../data_sources/remote/remote_data_source.dart';
import '../models/get_all_post_model.dart';
import '../models/param/get_all_post_param.dart';

class DefaultPostRepository implements PostRepository {
  final PostRemoteDataSource? remoteDataSource;

  DefaultPostRepository(this.remoteDataSource);

  @override
  Future<Either<ErrorEntity, GetAllPostEntity>> getAllPost(
      GetAllPostParams params) async {
    try {
//check connection
      bool isConnected = sl<NetworkInfo>().connectivityNotifier.value !=
          ConnectivityResult.none;
      final postData;
      postData = await remoteDataSource!.getAllPost(params);
      final postBox = await sl<HiveParamter>().hive.box(HiveKeys.postBox);

      GetAllPostModel? getAllPostModelLocal = postBox.get(HiveKeys.postListKey);
      if (getAllPostModelLocal == null) {
        getAllPostModelLocal =
            GetAllPostModel(skip: 0, total: 0, limit: 0, posts: []);
      }
      GetAllPostModel getAllPostModel = postData as GetAllPostModel;
      getAllPostModelLocal.posts!.addAll(getAllPostModel.posts ?? []);
      getAllPostModelLocal.posts!.toSet().toList();
      postBox.put(HiveKeys.postListKey, postData);

      return Right(postData.toEntity());
    } on AppException catch (e) {
      return Left(ErrorEntity.fromException(e));
    }
  }
}

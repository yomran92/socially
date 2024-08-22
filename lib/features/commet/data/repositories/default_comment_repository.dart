import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:todoapp/features/task/data/models/param/delete_task_param.dart';

import '../../../../core/error/app_exceptions.dart';
import '../../../../core/error/error_entity.dart';
import '../../../../core/utils/hive_keys.dart';
import '../../../../core/utils/hive_paramter.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/get_all_comment_entity.dart';
import '../../domain/entities/get_comment_entity.dart';
import '../../domain/repositories/comment_repository.dart';
import '../data_sources/remote/remote_data_source.dart';
import '../models/get_all_comment_model.dart';
import '../models/param/add_new_comment_param.dart';
import '../models/param/get_all_comment_param.dart';


class DefaultCommentRepository implements CommentRepository {
  final CommentRemoteDataSource? remoteDataSource;

  DefaultCommentRepository(this.remoteDataSource);

  @override
  Future<Either<ErrorEntity, GetAllCommentEntity>> getAllComment(
      GetAllCommentParams params) async {
    try {
//check connection
      bool isConnected = sl<NetworkInfo>().connectivityNotifier.value !=
          ConnectivityResult.none;
      final taskData;
      taskData = await remoteDataSource!.getAllComment(params);
      final taskBox = await sl<HiveParamter>().hive.box(HiveKeys.taskBox);

      GetAllCommentModel? getAllCommentModelLocal = taskBox.get(HiveKeys.taskListKey);
      if (getAllCommentModelLocal == null) {
        getAllCommentModelLocal =
            GetAllCommentModel(skip: 0, total: 0, limit: 0, todos: []);
      }
      GetAllCommentModel getAllTaskModel = taskData as GetAllCommentModel;
      getAllCommentModelLocal.todos!.addAll(getAllTaskModel.todos ?? []);
      getAllCommentModelLocal.todos!.toSet().toList();
      taskBox.put(HiveKeys.taskListKey, taskData);

      return Right(taskData.toEntity());
    } on AppException catch (e) {
      return Left(ErrorEntity.fromException(e));
    }
  }

  @override
  Future<Either<ErrorEntity, GetCommentEntity>> addNewComment(
      AddCommentParams task) async {
    try {
      final taskData;
      // bool isConnected = sl<NetworkInfo>().connectivityNotifier.value !=
      //     ConnectivityResult.none;
      //
      // if (!isConnected) {
      taskData = await remoteDataSource!.addNewComment(task);
      // } else {
      //   taskData = await localDataSource!.addNewTask(task);

      // }
      return Right(taskData.toEntity());
    } on AppException catch (e) {
      return Left(ErrorEntity.fromException(e));
    }
  }




}

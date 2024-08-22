import 'package:hive/hive.dart';

import '../../../../../core/data_sources/remote_data_source.dart';
import '../../models/comment_model.dart';
import '../../models/get_all_comment_model.dart';
import '../../models/param/add_new_comment_param.dart';
import '../../models/param/get_all_comment_param.dart';


abstract class ICommentRemoteDataSource extends RemoteDataSource {
  Future<GetAllCommentModel> getAllComment(GetAllCommentParams params);

  Future<CommentModel> addNewComment(AddCommentParams params);


}

class CommentRemoteDataSource extends ICommentRemoteDataSource {
  final HiveInterface? hiveInterface;

  CommentRemoteDataSource(
    this.hiveInterface,
  );

  @override
  Future<CommentModel> addNewComment(AddCommentParams params) async {
    var res = await this.post(params);
    return Future.value(CommentModel.fromJson(res));
  }



  @override
  Future<GetAllCommentModel> getAllComment(GetAllCommentParams params) async {
    var res;

    res = await this.get(params, withToken: true);

    return Future.value(GetAllCommentModel.fromJson(res));
  }


}

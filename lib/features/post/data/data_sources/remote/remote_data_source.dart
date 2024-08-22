import 'package:hive/hive.dart';

import '../../../../../core/data_sources/remote_data_source.dart';
import '../../models/get_all_post_model.dart';
import '../../models/param/get_all_post_param.dart';

abstract class IPostRemoteDataSource extends RemoteDataSource {
  Future<GetAllPostModel> getAllPost(GetAllPostParams params);


}

class PostRemoteDataSource extends IPostRemoteDataSource {
  final HiveInterface? hiveInterface;

  PostRemoteDataSource(
    this.hiveInterface,
  );



  @override
  Future<GetAllPostModel> getAllPost(GetAllPostParams params) async {
    var res;

    res = await this.get(params, withToken: true);

    return Future.value(GetAllPostModel.fromJson(res));
  }


}

import 'package:hive/hive.dart';

import '../../../../../core/data_sources/remote_data_source.dart';
import '../../models/get_all_story_model.dart';
import '../../models/param/get_all_story_param.dart';


abstract class IStoryRemoteDataSource extends RemoteDataSource {
  Future<GetAllStoryModel> getAllStory(GetAllStoryParams params);

}

class StoryRemoteDataSource extends IStoryRemoteDataSource {
  final HiveInterface? hiveInterface;

  StoryRemoteDataSource(
    this.hiveInterface,
  );




  @override
  Future<GetAllStoryModel> getAllStory(GetAllStoryParams params) async {
    var res;

    res = await this.get(params, withToken: true);

    return Future.value(GetAllStoryModel.fromJson(res));
  }

}

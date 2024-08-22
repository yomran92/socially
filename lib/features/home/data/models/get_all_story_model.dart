import 'package:hive/hive.dart';
import 'package:socially/features/home/data/models/story_model.dart';

import '../../domain/entities/get_all_story_entity.dart';
import '../../domain/entities/get_story_entity.dart';

part 'get_all_story_model.g.dart';

@HiveType(typeId: 1)
class GetAllStoryModel {
  @HiveField(0)
  List<StoryModel>? storys;

  @HiveField(1)
  int? total;
  @HiveField(2)
  int? skip;
  @HiveField(3)
  int? limit;

  GetAllStoryModel({this.storys, this.total, this.skip, this.limit});

  GetAllStoryModel.fromJson(json) {
    if (json['users'] != null) {
      storys = <StoryModel>[];
      json['users'].forEach((v) {
        storys!.add(new StoryModel.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.storys != null) {
      data['users'] = this.storys!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }

  @override
  GetAllStoryEntity toEntity() {
    List<GetStoryEntity> getStorysentities = [];
    if (storys == null) {
      storys = [];
    }
    storys!.forEach((element) {
      getStorysentities.add(element.toEntity());
    });
    return GetAllStoryEntity(
        total: total, limit: limit, skip: skip, storys: getStorysentities);
  }
}

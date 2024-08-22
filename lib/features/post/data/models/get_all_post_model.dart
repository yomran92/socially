import 'package:hive/hive.dart';
import 'package:socially/features/post/data/models/post_model.dart';

import '../../domain/entities/get_all_Post_entity.dart';
import '../../domain/entities/get_post_entity.dart';





part 'get_all_post_model.g.dart';

@HiveType(typeId: 3)
class GetAllPostModel {
  @HiveField(0)
  List<PostModel>? posts;

  @HiveField(1)
  int? total;
  @HiveField(2)
  int? skip;
  @HiveField(3)
  int? limit;

  GetAllPostModel({this.posts, this.total, this.skip, this.limit});

  GetAllPostModel.fromJson(json) {
    if (json['posts'] != null) {
      posts = <PostModel>[];
      json['posts'].forEach((v) {
        posts!.add(new PostModel.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }

  @override
  GetAllPostEntity toEntity() {
    List<GetPostEntity> getPostsentities = [];
    if (posts == null) {
      posts = [];
    }
    posts!.forEach((element) {
      getPostsentities.add(element.toEntity());
    });
    return GetAllPostEntity(
        total: total, limit: limit, skip: skip, posts: getPostsentities);
  }
}

import 'package:hive/hive.dart';
import 'package:todoapp/features/post/data/models/post_model.dart';

import '../../domain/entities/get_all_Post_entity.dart';
import '../../domain/entities/get_post_entity.dart';



@HiveType(typeId: 1)
class GetAllPostModel {
  @HiveField(0)
  List<PostModel>? todos;

  @HiveField(1)
  int? total;
  @HiveField(2)
  int? skip;
  @HiveField(3)
  int? limit;

  GetAllPostModel({this.todos, this.total, this.skip, this.limit});

  GetAllPostModel.fromJson(json) {
    if (json['todos'] != null) {
      todos = <PostModel>[];
      json['todos'].forEach((v) {
        todos!.add(new PostModel.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.todos != null) {
      data['todos'] = this.todos!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }

  @override
  GetAllPostEntity toEntity() {
    List<GetPostEntity> getPostsentities = [];
    if (todos == null) {
      todos = [];
    }
    todos!.forEach((element) {
      getPostsentities.add(element.toEntity());
    });
    return GetAllPostEntity(
        total: total, limit: limit, skip: skip, todos: getPostsentities);
  }
}

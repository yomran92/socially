import 'package:hive/hive.dart';
import 'package:socially/features/post/data/models/reation_model.dart';

import '../../domain/entities/get_post_entity.dart';

part 'post_model.g.dart';

@HiveType(typeId: 4)
class PostModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? body;
  @HiveField(3)
  int? userId;
  @HiveField(4)
  List<String>? tags;
  @HiveField(5)
  ReactionsModel? reactions;
  @HiveField(6)
  int? views;

  PostModel(
      {this.id,
      this.title,
      this.body,
      this.userId,
      this.reactions,
      this.tags,
      this.views});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    tags = json['tags'].cast<String>();
    reactions = json['reactions'] != null
        ? new ReactionsModel.fromJson(json['reactions'])
        : null;
    views = json['views'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['tags'] = this.tags;
    if (this.reactions != null) {
      data['reactions'] = this.reactions!.toJson();
    }
    data['views'] = this.views;
    data['userId'] = this.userId;
    return data;
  }

  @override
  GetPostEntity toEntity() {
    return GetPostEntity(
      id: id,
      title: title,
      reactions: reactions,
      tags: tags,
      views: views,
      body: body,
      userId: userId,
    );
  }
}

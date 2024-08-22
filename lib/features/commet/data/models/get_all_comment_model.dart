import 'package:hive/hive.dart';

import '../../domain/entities/get_all_comment_entity.dart';
import '../../domain/entities/get_comment_entity.dart';
import 'comment_model.dart';

@HiveType(typeId: 1)
class GetAllCommentModel {
  @HiveField(0)
  List<CommentModel>? todos;

  @HiveField(1)
  int? total;
  @HiveField(2)
  int? skip;
  @HiveField(3)
  int? limit;

  GetAllCommentModel({this.todos, this.total, this.skip, this.limit});

  GetAllCommentModel.fromJson(json) {
    if (json['todos'] != null) {
      todos = <CommentModel>[];
      json['todos'].forEach((v) {
        todos!.add(new CommentModel.fromJson(v));
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
  GetAllCommentEntity toEntity() {
    List<GetCommentEntity> getTasksentities = [];
    if (todos == null) {
      todos = [];
    }
    todos!.forEach((element) {
      getTasksentities.add(element.toEntity());
    });
    return GetAllCommentEntity(
        total: total, limit: limit, skip: skip, todos: getTasksentities);
  }
}

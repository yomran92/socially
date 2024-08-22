import 'package:hive/hive.dart';

import '../../domain/entities/get_comment_entity.dart';



@HiveType(typeId: 0)
class CommentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? todo;
  @HiveField(2)
  bool? completed;
  @HiveField(3)
  int? userId;

  CommentModel({this.id, this.todo, this.completed, this.userId});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['todo'] = this.todo;
    data['completed'] = this.completed;
    data['userId'] = this.userId;
    return data;
  }

  @override
  GetCommentEntity toEntity() {
    return GetCommentEntity(
      id: id,
      todo: todo,
      completed: completed,
      userId: userId,
    );
  }
}

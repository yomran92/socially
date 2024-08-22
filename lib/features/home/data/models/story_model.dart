import 'package:hive/hive.dart';

import '../../domain/entities/get_story_entity.dart';

part 'story_model.g.dart';

@HiveType(typeId: 0)
class StoryModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? todo;
  @HiveField(2)
  bool? completed;
  @HiveField(3)
  int? userId;

  StoryModel({this.id, this.todo, this.completed, this.userId});

  StoryModel.fromJson(Map<String, dynamic> json) {
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
  GetStoryEntity toEntity() {
    return GetStoryEntity(
      id: id,
      todo: todo,
      completed: completed,
      userId: userId,
    );
  }
}

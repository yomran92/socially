import 'package:hive/hive.dart';

import '../../domain/entities/get_story_entity.dart';

part 'story_model.g.dart';

@HiveType(typeId: 0)
class StoryModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? image;
  @HiveField(3)
  bool? isSeen;

  StoryModel({this.id, this.name, this.image, this.isSeen});

  StoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['firstName'];
    image = json['image'];
    isSeen = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.name;
    data['image'] = this.image;
    data['isSeen'] = this.isSeen;
    return data;
  }

  @override
  GetStoryEntity toEntity() {
    return GetStoryEntity(
      id: id,
      name: name,
      image: image,
      isSeen: isSeen,
    );
  }
}

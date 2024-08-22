import 'package:hive/hive.dart';

part 'reation_model.g.dart';

@HiveType(typeId: 5)
class ReactionsModel {
  @HiveField(0)
  int? likes;
  @HiveField(1)
  int? dislikes;

  ReactionsModel({this.likes, this.dislikes});

  ReactionsModel.fromJson(Map<String, dynamic> json) {
    likes = json['likes'];
    dislikes = json['dislikes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likes'] = this.likes;
    data['dislikes'] = this.dislikes;
    return data;
  }
}

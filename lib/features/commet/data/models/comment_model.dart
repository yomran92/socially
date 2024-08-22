import 'package:hive/hive.dart';

import '../../../account/data/remote/models/responses/user_model.dart';
import '../../domain/entities/get_comment_entity.dart';
part 'comment_model.g.dart';

@HiveType(typeId: 6)
class CommentModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? body;
  @HiveField(2)
  int? postId;
  @HiveField(3)
  int? likes;
  @HiveField(4)
  int? userId;

  @HiveField(5)

  UserModel? user;

  CommentModel({this.id, this.body, this.postId, this.likes,this.userId,this.user});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    postId = json['postId'];
    likes = json['likes'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['postId'] = this.postId;
    data['likes'] = this.likes;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }

  @override
  GetCommentEntity toEntity() {
    return GetCommentEntity(
      id: id,
      body: body,
      likes: likes,postId: postId,user: user,
    userId: userId
    );
  }
}

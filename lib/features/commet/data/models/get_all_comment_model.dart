import 'package:hive/hive.dart';

import '../../domain/entities/get_all_comment_entity.dart';
import '../../domain/entities/get_comment_entity.dart';
import 'comment_model.dart';
part 'get_all_comment_model.g.dart';

@HiveType(typeId: 7)
class GetAllCommentModel {
  @HiveField(0)
  List<CommentModel>? comments;

  @HiveField(1)
  int? total;
  @HiveField(2)
  int? skip;
  @HiveField(3)
  int? limit;

  GetAllCommentModel({this.comments, this.total, this.skip, this.limit});

  GetAllCommentModel.fromJson(json) {
    if (json['comments'] != null) {
      comments = <CommentModel>[];
      json['comments'].forEach((v) {
        comments!.add(new CommentModel.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }

  @override
  GetAllCommentEntity toEntity() {
    List<GetCommentEntity> getCommentssentities = [];
    if (comments == null) {
      comments = [];
    }
    comments!.forEach((element) {
      getCommentssentities.add(element.toEntity());
    });
    return GetAllCommentEntity(
        total: total, limit: limit, skip: skip, comments: getCommentssentities);
  }
}

import 'package:equatable/equatable.dart';

import '../../data/models/reation_model.dart';

class GetPostEntity extends Equatable {
  int? id;
  String? title;
  String? body;
  int? userId;
  List<String>? tags;
  ReactionsModel? reactions;
  int? views;

  GetPostEntity(
      {this.id,
      this.title,
      this.body,
      this.userId,
      this.tags,
      this.views,
      this.reactions});

  @override
  List<Object?> get props => [id, title, body, userId, tags, views, reactions];
}

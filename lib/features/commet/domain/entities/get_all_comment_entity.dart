import 'package:equatable/equatable.dart';

import 'get_comment_entity.dart';

class GetAllCommentEntity extends Equatable {
  final List<GetCommentEntity>? comments;

  final int? total;
  final int? skip;
  final int? limit;

  GetAllCommentEntity({this.comments, this.total, this.skip, this.limit});

  @override
  List<Object?> get props => [comments, total, skip, limit];
}

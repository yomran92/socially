import 'package:equatable/equatable.dart';

import 'get_comment_entity.dart';

class GetAllCommentEntity extends Equatable {
  final List<GetCommentEntity>? todos;

  final int? total;
  final int? skip;
  final int? limit;

  GetAllCommentEntity({this.todos, this.total, this.skip, this.limit});

  @override
  List<Object?> get props => [todos, total, skip, limit];
}

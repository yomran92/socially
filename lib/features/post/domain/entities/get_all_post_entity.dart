import 'package:equatable/equatable.dart';

import 'get_post_entity.dart';

class GetAllPostEntity extends Equatable {
  final List<GetPostEntity>? todos;

  final int? total;
  final int? skip;
  final int? limit;

  GetAllPostEntity({this.todos, this.total, this.skip, this.limit});

  @override
  List<Object?> get props => [todos, total, skip, limit];
}

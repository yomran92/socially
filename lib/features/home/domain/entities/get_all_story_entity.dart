import 'package:equatable/equatable.dart';

import 'get_story_entity.dart';

class GetAllStoryEntity extends Equatable {
  final List<GetStoryEntity>? todos;

  final int? total;
  final int? skip;
  final int? limit;

  GetAllStoryEntity({this.todos, this.total, this.skip, this.limit});

  @override
  List<Object?> get props => [todos, total, skip, limit];
}

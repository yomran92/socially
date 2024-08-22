import 'package:equatable/equatable.dart';

import 'get_story_entity.dart';

class GetAllStoryEntity extends Equatable {
  final List<GetStoryEntity>? storys;

  final int? total;
  final int? skip;
  final int? limit;

  GetAllStoryEntity({this.storys, this.total, this.skip, this.limit});

  @override
  List<Object?> get props => [storys, total, skip, limit];
}

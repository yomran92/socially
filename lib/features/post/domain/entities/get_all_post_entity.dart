import 'package:equatable/equatable.dart';

import 'get_post_entity.dart';

class GetAllPostEntity extends Equatable {
  final List<GetPostEntity>? posts;

  final int? total;
  final int? skip;
  final int? limit;

  GetAllPostEntity({  this.total, this.skip, this.limit, this.posts});

  @override
  List<Object?> get props => [posts, total, skip, limit];
}

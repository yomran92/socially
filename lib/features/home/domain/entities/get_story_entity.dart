import 'package:equatable/equatable.dart';

class GetStoryEntity extends Equatable {
  int? id;

  String? todo;

  bool? completed;

  int? userId;

  GetStoryEntity({this.id, this.todo, this.completed, this.userId});

  @override
  List<Object?> get props => [id, todo, completed, userId];
}

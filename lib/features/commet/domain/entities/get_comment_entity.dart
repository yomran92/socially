import 'package:equatable/equatable.dart';

class GetCommentEntity extends Equatable {
  int? id;

  String? todo;

  bool? completed;

  int? userId;

  GetCommentEntity({this.id, this.todo, this.completed, this.userId});

  @override
  List<Object?> get props => [id, todo, completed, userId];
}

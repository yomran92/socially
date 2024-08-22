import 'package:equatable/equatable.dart';

class GetPostEntity extends Equatable {
  int? id;

  String? todo;

  bool? completed;

  int? userId;

  GetPostEntity({this.id, this.todo, this.completed, this.userId});

  @override
  List<Object?> get props => [id, todo, completed, userId];
}

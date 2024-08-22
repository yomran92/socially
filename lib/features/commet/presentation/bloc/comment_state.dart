part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();
}

class CommentInitial extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentError extends CommentState {
  String message;

  CommentError({required this.message});

  @override
  List<Object> get props => [];
}

class GetAllCommentLoadedState extends CommentState {
  final List<GetCommentEntity>? comments;
  final int? total;
  final int? skip;
  final int? limit;

  GetAllCommentLoadedState({this.comments, this.skip, this.limit, this.total}
      // this.username,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        // tasks,
        // this.username,
      ];
}

class AddNewCommentState extends CommentState {
  final GetCommentEntity task;

  AddNewCommentState(
    this.task,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
        task,
        // this.username,
      ];
}

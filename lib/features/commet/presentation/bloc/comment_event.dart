part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
}

class ResetBlocEvent extends CommentEvent {
  // final String username;

  ResetBlocEvent(// this.username
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        // username
      ];
}


class GetAllCommentEvent extends CommentEvent {
  final GetAllCommentParams params;

  GetAllCommentEvent({
    required this.params,
  });

  @override
  // Task: implement props
  List<Object?> get props => [
        // username
      ];
}

class AddNewCommentEvent extends CommentEvent {
  final AddCommentParams addCommentParams;

  AddNewCommentEvent({required this.addCommentParams});

  @override
  // TODO: implement props
  List<Object?> get props => [addCommentParams];
}

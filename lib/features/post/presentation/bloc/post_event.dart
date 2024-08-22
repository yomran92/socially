part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class GetAllPostEvent extends PostEvent {
  final GetAllPostParams params;

  GetAllPostEvent({
    required this.params,
  });

  @override
  // Task: implement props
  List<Object?> get props => [
        // username
      ];
}

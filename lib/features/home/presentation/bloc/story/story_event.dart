part of 'story_bloc.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();
}

class ResetBlocEvent extends StoryEvent {
  // final String username;

  ResetBlocEvent(// this.username
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        // username
      ];
}

class GetAllStoryEvent extends StoryEvent {
  final GetAllStoryParams params;

  GetAllStoryEvent({
    required this.params,
  });

  @override
  // Task: implement props
  List<Object?> get props => [
        // username
      ];
}

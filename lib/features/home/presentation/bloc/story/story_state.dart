part of 'story_bloc.dart';


abstract class StoryState extends Equatable {
  const StoryState();
}

class StoryInitial extends StoryState {
  @override
  List<Object> get props => [];
}

class StoryLoading extends StoryState {
  @override
  List<Object> get props => [];
}

class StoryError extends StoryState {
  String message;

  StoryError({required this.message});

  @override
  List<Object> get props => [];
}

class GetAllStoryLoadedState extends StoryState {
  final List<GetStoryEntity>? tasks;
  final int? total;
  final int? skip;
  final int? limit;

  GetAllStoryLoadedState({this.tasks, this.skip, this.limit, this.total}
      // this.username,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        // tasks,
        // this.username,
      ];
}


part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostError extends PostState {
  String message;

  PostError({required this.message});

  @override
  List<Object> get props => [];
}

class GetAllPostLoadedState extends PostState {
  final List<GetPostEntity>? tasks;
  final int? total;
  final int? skip;
  final int? limit;

  GetAllPostLoadedState({this.tasks, this.skip, this.limit, this.total}
      // this.username,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        // tasks,
        // this.username,
      ];
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socially/service_locator.dart';

import '../../../data/models/param/get_all_story_param.dart';
import '../../../domain/entities/get_story_entity.dart';
import '../../../domain/repositories/story_repository.dart';
import '../../../domain/usecases/get_all_story_usecase.dart';

part 'story_event.dart';part 'story_state.dart';

const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc(// this._taskervice
      )
      : super(StoryInitial()) {
    on<GetAllStoryEvent>((event, emit) async {
      emit(StoryLoading());

      var res =
          await GetAllStoryUsecase(sl<StoryRepository>()).call(event.params);
      emit(res.fold(
          (l) => StoryError(message: l.errorMessage ?? ''),
          (r) => GetAllStoryLoadedState(
              skip: r.skip, limit: r.limit, storys: r.storys, total: r.total)));
    });
  }
}

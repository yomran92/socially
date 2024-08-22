import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socially/service_locator.dart';

import '../../data/models/param/get_all_post_param.dart';
import '../../domain/entities/get_post_entity.dart';
import '../../domain/repositories/Post_repository.dart';
import '../../domain/usecases/get_all_post_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(// this._Postervice
      )
      : super(PostInitial()) {
    on<GetAllPostEvent>((event, emit) async {
      emit(PostLoading());

      var res =
          await GetAllPostUsecase(sl<PostRepository>()).call(event.params);
      emit(res.fold(
          (l) => PostError(message: l.errorMessage ?? ''),
          (r) => GetAllPostLoadedState(
              skip: r.skip, limit: r.limit, post: r.todos, total: r.total)));
    });
  }
}

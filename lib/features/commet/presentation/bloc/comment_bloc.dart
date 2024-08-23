import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socially/service_locator.dart';

import '../../data/models/param/add_new_comment_param.dart';
import '../../data/models/param/get_all_comment_param.dart';
import '../../domain/entities/get_comment_entity.dart';
import '../../domain/repositories/comment_repository.dart';
import '../../domain/usecases/add_new_comment_usecase.dart';
import '../../domain/usecases/get_all_comment_usecase.dart';

part 'comment_event.dart';
part 'comment_state.dart';

const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc(// this._taskervice
      )
      : super(CommentInitial()) {
    on<GetAllCommentEvent>((event, emit) async {
      emit(CommentLoading());

      var res = await GetAllCommentUsecase(sl<CommentRepository>())
          .call(event.params);
      emit(res.fold(
          (l) => CommentError(message: l.errorMessage ?? ''),
          (r) => GetAllCommentLoadedState(
              skip: r.skip,
              limit: r.limit,
              comments: r.comments,
              total: r.total)));
    });

    on<AddNewCommentEvent>((event, emit) async {
      emit(CommentLoading());

      var res = await AddNewCommentUsecase(sl<CommentRepository>())
          .call(event.addCommentParams);
      emit(res.fold(
          (l) => AddCommentError(message: l.errorMessage ?? ''),
          (r) => AddNewCommentState(GetCommentEntity(
                id: r.id,
                body: r.body,
                // completed: r.completed,
                userId: r.userId,
              ))));
    });
  }
}

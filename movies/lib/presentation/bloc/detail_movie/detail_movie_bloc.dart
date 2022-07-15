import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailsMoviesBloc extends Bloc<DetailsMoviesEvent, DetailsMoviesState> {
  final GetMovieDetail getMovieDetail;

  DetailsMoviesBloc(this.getMovieDetail) : super(MoviesDetailsEmpty()) {
    on<GetDetailsMoviesEvent>(_loadMovieDetail);
  }
  FutureOr<void> _loadMovieDetail(
    GetDetailsMoviesEvent event,
    Emitter<DetailsMoviesState> emit,
  ) async {
    emit(MoviesDetailsLoading());
    final result = await getMovieDetail.execute(event.id);
    result.fold(
      (failure) {
        emit(MoviesDetailsError(failure.message));
      },
      (data) {
        emit(MoviesDetailsLoaded(data));
      },
    );
  }
}

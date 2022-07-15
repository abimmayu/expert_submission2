import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedsMoviesBloc
    extends Bloc<TopRatedsMoviesEvent, TopRatedsMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedsMoviesBloc(this.getTopRatedMovies) : super(TopRatedsMoviesEmpty()) {
    on<TopRatedsMoviesGetEvent>(_loadTopRated);
  }

  FutureOr<void> _loadTopRated(
    TopRatedsMoviesGetEvent event,
    Emitter<TopRatedsMoviesState> emit,
  ) async {
    emit(TopRatedsMoviesLoading());
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(TopRatedsMoviesError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TopRatedsMoviesEmpty())
            : emit(TopRatedsMoviesLoaded(data));
      },
    );
  }
}

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';

part 'recommended_movies_event.dart';
part 'recommended_movies_state.dart';

class RecommendMoviesBloc
    extends Bloc<RecommendMoviesEvent, RecommendMoviesState> {
  final GetMovieRecommendations getMovieRecommendations;

  RecommendMoviesBloc(this.getMovieRecommendations)
      : super(RecommendMoviesEmpty()) {
    on<GetRecommendMoviesEvent>(_loadRecommendMovies);
  }

  FutureOr<void> _loadRecommendMovies(
    GetRecommendMoviesEvent event,
    Emitter<RecommendMoviesState> emit,
  ) async {
    emit(RecommendMoviesLoading());
    final result = await getMovieRecommendations.execute(event.id);
    result.fold(
      (failure) {
        emit(RecommendMoviesError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(RecommendMoviesEmpty())
            : emit(RecommendMoviesLoaded(data));
      },
    );
  }
}

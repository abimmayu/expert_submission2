import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:search/domain/usecases/search_movies.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc({
    required this.searchMovies,
  }) : super(SearchMoviesEmpty()) {
    on<MovieSearchSetEmpty>((event, emit) => emit(SearchMoviesEmpty()));
    on<MovieSearchQueryEvent>((event, emit) async {
      emit(SearchMoviesLoading());
      final result = await searchMovies.execute(event.query);
      result.fold(
        (failure) {
          emit(SearchMoviesError(failure.message));
        },
        (data) {
          emit(SearchMoviesLoaded(data));
        },
      );
    });
  }
}

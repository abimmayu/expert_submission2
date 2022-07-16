import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/movies.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  static const watchlistRemoveSuccessMessage =
      'Successfully removed from watchlist';
  static const watchlistAddSuccessMessage = 'Successfully added to watchlist';
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchlistStatus;

  WatchlistMoviesBloc(this.saveWatchlist, this.removeWatchlist,
      this.getWatchlistMovies, this.getWatchlistStatus)
      : super(WatchlistMoviesEmpty()) {
    on<GetListEvent>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final result = await getWatchlistMovies.execute();
      result.fold((failure) {
        emit(WatchlistMoviesError(failure.message));
      }, (data) {
        data.isEmpty
            ? emit(WatchlistMoviesEmpty())
            : emit(WatchlistMoviesLoaded(data));
      });
    });
    on<GetStatusMovieEvent>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final result = await getWatchlistStatus.execute(event.id);
      emit(MovieWatchlistStatusLoaded(result));
    });
    on<AddItemMovieEvent>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await saveWatchlist.execute(movieDetail);
      result.fold(
        (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
        (successMessage) {
          emit(MovieWatchlistSuccess(successMessage));
        },
      );
    });
    on<RemoveItemMovieEvent>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await removeWatchlist.execute(movieDetail);
      result.fold(
        (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
        (successMessage) {
          emit(MovieWatchlistSuccess(successMessage));
        },
      );
    });
  }
}

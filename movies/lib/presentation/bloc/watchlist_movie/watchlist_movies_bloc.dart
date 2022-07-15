import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  WatchlistMoviesBloc({
    required this.getWatchlistMovies,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchlistMoviesEmpty()) {
    on<GetListEvent>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
        (data) {
          emit(WatchlistMoviesLoaded(data));
        },
      );
    });

    on<GetStatusMovieEvent>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);

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

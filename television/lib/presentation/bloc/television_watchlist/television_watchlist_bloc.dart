import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:television/domain/entities/television.dart';
import 'package:television/domain/entities/television_detail.dart';
import 'package:television/domain/usecase/television_get_watchlist.dart';
import 'package:television/domain/usecase/television_get_watchlist_status.dart';
import 'package:television/domain/usecase/television_remove_watchlist.dart';
import 'package:television/domain/usecase/television_save_watchlist.dart';

part 'television_watchlist_event.dart';
part 'television_watchlist_state.dart';

class WatchlistTvsBloc extends Bloc<WatchlistTvsEvent, WatchlistTvsState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTv getWatchlistTv;
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  WatchlistTvsBloc({
    required this.getWatchlistTv,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(WatchlistTvsEmpty()) {
    on<GetListEvent>((event, emit) async {
      emit(WatchlistTvsLoading());
      final result = await getWatchlistTv.execute();
      result.fold(
        (failure) {
          emit(WatchlistTvsError(failure.message));
        },
        (data) {
          emit(WatchlistTvsLoaded(data));
        },
      );
    });

    on<GetStatusTvsEvent>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);

      emit(WatchlistTvsStatusLoaded(result));
    });

    on<AddItemTvsEvent>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await saveWatchlist.execute(tvDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvsError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvsSuccess(successMessage));
        },
      );
    });

    on<RemoveItemTvsEvent>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await removeWatchlist.execute(tvDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvsError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvsSuccess(successMessage));
        },
      );
    });
  }
}

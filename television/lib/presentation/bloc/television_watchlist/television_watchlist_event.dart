part of 'television_watchlist_bloc.dart';

abstract class WatchlistTvsEvent extends Equatable {
  const WatchlistTvsEvent();

  @override
  List<Object> get props => [];
}

class GetListEvent extends WatchlistTvsEvent {}

class GetStatusTvsEvent extends WatchlistTvsEvent {
  final int id;

  const GetStatusTvsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddItemTvsEvent extends WatchlistTvsEvent {
  final TvDetail tvDetail;

  const AddItemTvsEvent(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveItemTvsEvent extends WatchlistTvsEvent {
  final TvDetail tvDetail;

  const RemoveItemTvsEvent(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

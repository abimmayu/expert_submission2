part of 'search_television_bloc.dart';

abstract class SearchTvsEvent extends Equatable {
  const SearchTvsEvent();

  @override
  List<Object> get props => [];
}

class TvSearchSetEmpty extends SearchTvsEvent {}

class TvSearchQueryEvent extends SearchTvsEvent {
  final String query;

  const TvSearchQueryEvent(this.query);

  @override
  List<Object> get props => [];
}

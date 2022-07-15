part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object> get props => [];
}

class MovieSearchSetEmpty extends SearchMoviesEvent {}

class MovieSearchQueryEvent extends SearchMoviesEvent {
  final String query;

  const MovieSearchQueryEvent(this.query);

  @override
  List<Object> get props => [];
}

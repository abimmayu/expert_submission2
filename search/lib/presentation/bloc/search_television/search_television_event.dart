part of 'search_television_bloc.dart';

abstract class SearchTvsState extends Equatable {
  const SearchTvsState();

  @override
  List<Object> get props => [];
}

class SearchTvsEmpty extends SearchTvsState {}

class SearchTvsLoading extends SearchTvsState {}

class SearchTvsError extends SearchTvsState {
  final String message;

  const SearchTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvsLoaded extends SearchTvsState {
  final List<Tv> result;

  const SearchTvsLoaded(this.result);

  @override
  List<Object> get props => [result];
}

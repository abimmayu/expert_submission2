part of 'detail_movie_bloc.dart';

abstract class DetailsMoviesState extends Equatable {}

class MoviesDetailsEmpty extends DetailsMoviesState {
  @override
  List<Object> get props => [];
}

class MoviesDetailsLoading extends DetailsMoviesState {
  @override
  List<Object> get props => [];
}

class MoviesDetailsLoaded extends DetailsMoviesState {
  final MovieDetail movieDetail;
  MoviesDetailsLoaded(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class MoviesDetailsError extends DetailsMoviesState {
  @override
  List<Object> get props => [message];

  final String message;
  MoviesDetailsError(this.message);
}

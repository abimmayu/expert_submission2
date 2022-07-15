part of 'top_rated_movies_bloc.dart';

abstract class TopRatedsMoviesEvent extends Equatable {
  const TopRatedsMoviesEvent();

  @override
  List<Object> get props => [];
}

@immutable
class TopRatedsMoviesGetEvent extends TopRatedsMoviesEvent {}

part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingsMoviesEvent extends Equatable {
  const NowPlayingsMoviesEvent();
  @override
  List<Object> get props => [];
}

@immutable
class NowPlayingsMoviesGetEvent extends NowPlayingsMoviesEvent {}

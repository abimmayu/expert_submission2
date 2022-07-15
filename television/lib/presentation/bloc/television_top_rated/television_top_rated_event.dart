part of 'television_top_rated_bloc.dart';

abstract class TopRatedsTvsEvent extends Equatable {
  const TopRatedsTvsEvent();

  @override
  List<Object> get props => [];
}

class TopRatedsTvsGetEvent extends TopRatedsTvsEvent {}

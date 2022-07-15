part of 'television_popular_bloc.dart';

abstract class PopularsTvsEvent extends Equatable {
  const PopularsTvsEvent();

  @override
  List<Object> get props => [];
}

class PopularsTvsGetEvent extends PopularsTvsEvent {}

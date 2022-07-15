part of 'television_popular_bloc.dart';

abstract class PopularsTvsState extends Equatable {
  const PopularsTvsState();

  @override
  List<Object> get props => [];
}

class PopularsTvsEmpty extends PopularsTvsState {}

class PopularsTvsLoading extends PopularsTvsState {}

class PopularsTvsError extends PopularsTvsState {
  final String message;

  const PopularsTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularsTvsLoaded extends PopularsTvsState {
  final List<Tv> result;

  const PopularsTvsLoaded(this.result);

  @override
  List<Object> get props => [result];
}

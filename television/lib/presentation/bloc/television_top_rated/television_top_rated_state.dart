part of 'television_top_rated_bloc.dart';

abstract class TopRatedsTvsState extends Equatable {
  const TopRatedsTvsState();

  @override
  List<Object> get props => [];
}

class TopRatedsTvsEmpty extends TopRatedsTvsState {}

class TopRatedsTvsLoading extends TopRatedsTvsState {}

class TopRatedsTvsError extends TopRatedsTvsState {
  final String message;

  const TopRatedsTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedsTvsLoaded extends TopRatedsTvsState {
  final List<Tv> result;

  const TopRatedsTvsLoaded(this.result);

  @override
  List<Object> get props => [result];
}

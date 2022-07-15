part of 'television_recommend_bloc.dart';

abstract class RecommendTvsState extends Equatable {
  const RecommendTvsState();

  @override
  List<Object> get props => [];
}

class RecommendTvsEmpty extends RecommendTvsState {}

class RecommendTvsLoading extends RecommendTvsState {}

class RecommendTvsError extends RecommendTvsState {
  final String message;

  const RecommendTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendTvsLoaded extends RecommendTvsState {
  final List<Tv> tv;

  const RecommendTvsLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}

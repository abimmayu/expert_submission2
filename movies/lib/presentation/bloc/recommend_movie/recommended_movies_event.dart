part of 'recommended_movies_bloc.dart';

class GetRecommendMoviesEvent extends RecommendMoviesEvent {
  final int id;
  GetRecommendMoviesEvent(this.id);

  @override
  List<Object> get props => [id];
}

abstract class RecommendMoviesEvent extends Equatable {}

part of 'television_recommend_bloc.dart';

abstract class RecommendTvsEvent extends Equatable {
  const RecommendTvsEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendTvsEvent extends RecommendTvsEvent {
  final int id;

  const GetRecommendTvsEvent(this.id);

  @override
  List<Object> get props => [];
}

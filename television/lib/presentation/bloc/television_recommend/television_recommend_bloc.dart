import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:television/domain/entities/television.dart';
import 'package:television/domain/usecase/television_get_recommendation.dart';

part 'television_recommend_event.dart';
part 'television_recommend_state.dart';

class RecommendTvsBloc extends Bloc<RecommendTvsEvent, RecommendTvsState> {
  final GetTvRecommendations getTvRecommendations;

  RecommendTvsBloc({
    required this.getTvRecommendations,
  }) : super(RecommendTvsEmpty()) {
    on<GetRecommendTvsEvent>((event, emit) async {
      emit(RecommendTvsLoading());
      final result = await getTvRecommendations.execute(event.id);
      result.fold(
        (failure) {
          emit(RecommendTvsError(failure.message));
        },
        (data) {
          emit(RecommendTvsLoaded(data));
        },
      );
    });
  }
}

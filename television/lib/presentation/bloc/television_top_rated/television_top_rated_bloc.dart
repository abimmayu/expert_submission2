import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:television/domain/entities/television.dart';
import 'package:television/domain/usecase/television_get_top_rated.dart';

part 'television_top_rated_event.dart';
part 'television_top_rated_state.dart';

class TopRatedsTvsBloc extends Bloc<TopRatedsTvsEvent, TopRatedsTvsState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedsTvsBloc(
    this.getTopRatedTv,
  ) : super(TopRatedsTvsEmpty()) {
    on<TopRatedsTvsGetEvent>((event, emit) async {
      emit(TopRatedsTvsLoading());
      final result = await getTopRatedTv.execute();
      result.fold(
        (failure) {
          emit(TopRatedsTvsError(failure.message));
        },
        (data) {
          emit(TopRatedsTvsLoaded(data));
        },
      );
    });
  }
}

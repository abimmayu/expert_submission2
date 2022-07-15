import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:television/domain/entities/television.dart';
import 'package:television/domain/usecase/television_get_popular.dart';

part 'television_popular_event.dart';
part 'television_popular_state.dart';

class PopularsTvsBloc extends Bloc<PopularsTvsEvent, PopularsTvsState> {
  final GetPopularTv getPopularTv;

  PopularsTvsBloc(
    this.getPopularTv,
  ) : super(PopularsTvsEmpty()) {
    on<PopularsTvsGetEvent>((event, emit) async {
      emit(PopularsTvsLoading());
      final result = await getPopularTv.execute();
      result.fold(
        (failure) {
          emit(PopularsTvsError(failure.message));
        },
        (data) {
          emit(PopularsTvsLoaded(data));
        },
      );
    });
  }
}

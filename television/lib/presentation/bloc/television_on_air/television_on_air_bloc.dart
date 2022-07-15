import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:television/domain/entities/television.dart';
import 'package:television/domain/usecase/television_get_now_playing.dart';

part 'television_on_air_event.dart';
part 'television_on_air_state.dart';

class OnAirsTvsBloc extends Bloc<OnAirsTvsEvent, OnAirsTvsState> {
  final GetNowPlayingTv getOnAirTv;

  OnAirsTvsBloc(
    this.getOnAirTv,
  ) : super(OnAirsTvsEmpty()) {
    on<OnAirsTvsGetEvent>((event, emit) async {
      emit(OnAirsTvsLoading());
      final result = await getOnAirTv.execute();
      result.fold(
        (failure) {
          emit(OnAirsTvsError(failure.message));
        },
        (data) {
          emit(OnAirsTvsLoaded(data));
        },
      );
    });
  }
}

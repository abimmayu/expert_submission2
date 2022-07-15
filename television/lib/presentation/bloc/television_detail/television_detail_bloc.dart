import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:television/domain/entities/television_detail.dart';
import 'package:television/domain/usecase/television_get_detail.dart';
part 'television_detail_event.dart';
part 'television_detail_state.dart';

class DetailsTvsBloc extends Bloc<DetailsTvsEvent, DetailsTvsState> {
  final GetTvDetail getTvDetail;

  DetailsTvsBloc({
    required this.getTvDetail,
  }) : super(DetailsTvsEmpty()) {
    on<GetDetailsTvsEvent>((event, emit) async {
      emit(DetailsTvsLoading());
      final result = await getTvDetail.execute(event.id);
      result.fold(
        (failure) {
          emit(DetailsTvsError(failure.message));
        },
        (data) {
          emit(DetailTvsLoaded(data));
        },
      );
    });
  }
}

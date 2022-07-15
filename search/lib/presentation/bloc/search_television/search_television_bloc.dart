import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/domain/usecases/search_television.dart';
import 'package:television/domain/entities/television.dart';

part 'search_television_event.dart';
part 'search_television_state.dart';

class SearchTvsBloc extends Bloc<SearchTvsEvent, SearchTvsState> {
  final SearchTv searchTv;

  SearchTvsBloc({
    required this.searchTv,
  }) : super(SearchTvsEmpty()) {
    on<TvSearchSetEmpty>((event, emit) => emit(SearchTvsEmpty()));

    on<TvSearchQueryEvent>((event, emit) async {
      emit(SearchTvsLoading());
      final result = await searchTv.execute(event.query);
      result.fold(
        (failure) {
          emit(SearchTvsError(failure.message));
        },
        (data) {
          emit(SearchTvsLoaded(data));
        },
      );
    });
  }
}

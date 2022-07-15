part of 'detail_movie_bloc.dart';

class GetDetailsMoviesEvent extends DetailsMoviesEvent {
  final int id;
  GetDetailsMoviesEvent(this.id);

  @override
  List<Object> get props => [id];
}

abstract class DetailsMoviesEvent extends Equatable {}

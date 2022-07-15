part of 'television_detail_bloc.dart';

abstract class DetailsTvsState extends Equatable {
  const DetailsTvsState();

  @override
  List<Object> get props => [];
}

class DetailsTvsEmpty extends DetailsTvsState {}

class DetailsTvsLoading extends DetailsTvsState {}

class DetailsTvsError extends DetailsTvsState {
  final String message;

  const DetailsTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTvsLoaded extends DetailsTvsState {
  final TvDetail tvDetail;

  const DetailTvsLoaded(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

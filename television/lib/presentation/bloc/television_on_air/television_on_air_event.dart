part of 'television_on_air_bloc.dart';

abstract class OnAirsTvsState extends Equatable {
  const OnAirsTvsState();

  @override
  List<Object> get props => [];
}

class OnAirsTvsEmpty extends OnAirsTvsState {}

class OnAirsTvsLoading extends OnAirsTvsState {}

class OnAirsTvsError extends OnAirsTvsState {
  final String message;

  const OnAirsTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class OnAirsTvsLoaded extends OnAirsTvsState {
  final List<Tv> result;

  const OnAirsTvsLoaded(this.result);

  @override
  List<Object> get props => [result];
}

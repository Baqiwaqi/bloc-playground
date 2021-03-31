part of 'rocket_bloc.dart';

@immutable
abstract class RocketEvent extends Equatable {
  const RocketEvent();
  @override
  List<Object> get props => [];
}

class FetchRocketEvent extends RocketEvent {
  @override
  List<Object> get props => [];
}

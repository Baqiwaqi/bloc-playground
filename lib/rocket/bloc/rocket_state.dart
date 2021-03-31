part of 'rocket_bloc.dart';

@immutable
abstract class RocketState extends Equatable {
  const RocketState();

  @override
  List<Object> get props => [];
}

class RocketInitial extends RocketState {}

class RocketLoadInProgres extends RocketState {}

class RocketLoadSuccess extends RocketState {
  final List<RocketModel> rockets;

  RocketLoadSuccess(
    this.rockets,
  ) : assert(rockets != null);

  @override
  List<Object> get props => [rockets];
}

class RocketLoadFailure extends RocketState {}

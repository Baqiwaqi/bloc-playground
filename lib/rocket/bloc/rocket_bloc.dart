import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:direct_navigation/rocket/data/models/rocket_model.dart';
import 'package:direct_navigation/rocket/data/repositories/rocket_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'rocket_event.dart';
part 'rocket_state.dart';

class RocketBloc extends Bloc<RocketEvent, RocketState> {
  RocketBloc({
    @required this.rocketRepository,
  })  : assert(rocketRepository != null),
        super(RocketInitial());

  final RocketRepository rocketRepository;

  @override
  Stream<RocketState> mapEventToState(RocketEvent event) async* {
    if (event is FetchRocketEvent) {
      yield* _mapRocketLoadToState(event);
    }
  }

  Stream<RocketState> _mapRocketLoadToState(FetchRocketEvent rocket) async* {
    yield RocketLoadInProgres();
    try {
      List<RocketModel> rocket = await rocketRepository.getRockets();
      yield RocketLoadSuccess(rocket);
    } catch (_) {
      yield RocketLoadFailure();
    }
  } 
}

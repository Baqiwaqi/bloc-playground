import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../repositories/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker,
        super(TimerInitial(_duration));

  // TimerInitial state Duration of 1 minute (60 seconds).
  static int _duration = 10;

  // we need to define the dependency on our Ticker.
  final Ticker _ticker;
  StreamSubscription<int> _tickerSubscription;

  //  For improved readability,
  //  I like to break out each event handler into its own helper function.
  //  We’ll start with the TimerStarted event.
  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStarted) {
      yield* _mapTimerStartedToState(event);
    } 
    else if (event is TimerPaused) {
      yield* _mapTimerPausedToState(event);
    }
    else if (event is TimerResumed) {
      yield* _mapTimerResumedToState(event);
    }
    else if (event is TimerReset) {
      yield* _mapTimerResetToState(event);
    }
    else if (event is TimerTicked) {
      yield* _mapTimerTickedToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<TimerState> _mapTimerStartedToState(TimerStarted start) async* {
    // TimerRunInProgress state with the start timer
    yield TimerRunInProgress(start.duration);
    //  if there was already an open _tickerSubscription we need to cancel it
    _tickerSubscription?.cancel();
    // _ticker.tick stream
    // we add a TimerTicked event with the remaining duration.
    _tickerSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  // implement the TimerPaused event handler.
  @override
  Stream<TimerState> _mapTimerPausedToState(TimerPaused paused) async* {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      yield TimerRunPause(state.duration);
    }
  }
  // TimerResumed event handler so that we can unpause the timer.
  @override
  Stream<TimerState> _mapTimerResumedToState(TimerResumed resume) async* {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      yield TimerRunInProgress(state.duration);
    }
  }
  // TimerReset event handler.
  @override
  Stream<TimerState> _mapTimerResetToState(TimerReset reset) async* {
    _tickerSubscription.cancel();
    yield TimerInitial(_duration);
  }
  // if the tick’s duration is greater than 0,
  // we need to push an updated TimerRunInProgress state with the new duration.
  // Otherwise, if the tick’s duration is 0,
  // our timer has ended and we need to push a TimerRunComplete state.
  @override
  Stream<TimerState> _mapTimerTickedToState(TimerTicked tick) async* {
    yield tick.duration > 0
        ? TimerRunInProgress(tick.duration)
        : TimerRunComplete();
  }
}

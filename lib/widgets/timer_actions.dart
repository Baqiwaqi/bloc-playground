import 'package:direct_navigation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
        timerBloc: BlocProvider.of<TimerBloc>(context),
      ),
    );
  }

  // Actions widget which will have the proper actions (start, pause, and reset)
  List<Widget> _mapStateToActionButtons({TimerBloc timerBloc}) {
    final TimerState currentState = timerBloc.state;
    
    //start
    if (currentState is TimerInitial) {
      return [
        FloatingActionButton(
          heroTag: 'play',
          child: Icon(Icons.play_arrow),
          onPressed: () =>
              timerBloc.add(TimerStarted(duration: currentState.duration)),
        ),
      ];
    }
    //inProgress
    if (currentState is TimerRunInProgress) {
      return [
        FloatingActionButton(
          heroTag: 'pause',
          child: Icon(Icons.pause),
          onPressed: () =>
            timerBloc.add(TimerPaused())
        ),
        FloatingActionButton(
          heroTag: 'reset',
          child: Icon(Icons.replay),
          onPressed: () =>
              timerBloc.add(TimerReset())
        ),
      ];
    }
    //pause
    if (currentState is TimerRunPause) {
      return [
        FloatingActionButton(
          heroTag: 'play',
          child: Icon(Icons.play_arrow),
          onPressed: () =>
              timerBloc.add(TimerResumed()),
        ),
        FloatingActionButton(
          heroTag: 'reset',
          child: Icon(Icons.replay),
          onPressed: ()  =>
              timerBloc.add(TimerReset()),
        )
      ];
    }
    //reset
    if (currentState is TimerRunComplete) {
      return [
        FloatingActionButton(
          heroTag: 'reset',
          child: Icon(Icons.replay),
          onPressed: () =>
              timerBloc.add(TimerReset()),
        ),
      ];
    }
    return [];
  }
}

import 'package:direct_navigation/bloc/timer/bloc/timer_bloc.dart';
import 'package:direct_navigation/widgets/side_menu.dart';
import 'package:direct_navigation/widgets/timer_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Timer extends StatelessWidget {
  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 120,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      drawer: SideMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Center(
              child: BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  //minuten to string
                  final String minuteStr = ((state.duration / 60) % 60)
                      .floor()
                      .toString()
                      .padLeft(2, '0');
                  //seconds to string
                  final String secondStr =
                      (state.duration % 60).floor().toString().padLeft(2, "0");

                  return Text(
                    '$minuteStr : $secondStr',
                    style: Timer.timerTextStyle,
                  );
                },
              ),
            ),
          ),
          BlocBuilder<TimerBloc, TimerState>(
            buildWhen: (previousState, currentState) =>
              currentState.runtimeType != previousState.runtimeType,
            builder:  (contect, state) => TimerActions(),
          ),
        ],
      ),
    );
  }
}

import 'package:direct_navigation/bloc/bloc.dart';
import 'package:direct_navigation/cubit/counter_cubit.dart';
import 'package:direct_navigation/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Combine page'),
      ),
      drawer: SideMenu(),


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('The count is currently: '),
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
              return Text('${state.counterValue}');
              },
            ),
            SizedBox(height: 16.0,),
            Text('Current remaining on the timer'),
            BlocBuilder<TimerBloc, TimerState>(
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
                    
                  );
              })
          ],
        )
      ),
    );
  }
}

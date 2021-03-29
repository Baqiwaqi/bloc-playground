import 'package:direct_navigation/cubit/counter_cubit.dart';
import 'package:direct_navigation/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterCubit = BlocProvider.of<CounterCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Page A'),
      ),
      drawer: SideMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("The counter is pressed this many times: "),
            BlocConsumer<CounterCubit, CounterState>(builder: (context, state) {
              return Text(
                '${state.counterValue}',
              );
            }, listener: (context, state) {
              if (state.wasIncremented) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Incremented!!'),
                    duration: Duration(milliseconds: 300),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Decremented!!'),
                    duration: Duration(milliseconds: 300)
                  ),
                );
              }
            })
          ],
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 0,
            child: Icon(Icons.add),
            onPressed: () => counterCubit.increment(),
          ),
          SizedBox(
            width: 16.0,
          ),
          FloatingActionButton(
            heroTag: 1,
            child: Icon(Icons.remove),
            onPressed: () => counterCubit.decrement(),
          ),
        ],
      ),
    );
  }
}

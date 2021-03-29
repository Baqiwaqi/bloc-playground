import 'package:direct_navigation/cubit/counter_cubit.dart';
import 'package:direct_navigation/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('page B'),
      ),
      drawer: SideMenu(),
      body: BlocBuilder<CounterCubit, CounterState>(
        builder: (context, state) {
          return Center(
            child: Text('${state.counterValue}'),
          );
        },
      ),
    );
  }
}

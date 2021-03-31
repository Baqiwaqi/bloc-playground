import 'dart:developer';

import 'package:direct_navigation/bloc/bloc.dart';
import 'package:direct_navigation/cubit/counter_cubit.dart';
import 'package:direct_navigation/pages/page_a.dart';
import 'package:direct_navigation/pages/page_b.dart';
import 'package:direct_navigation/pages/timer.dart';
import 'package:direct_navigation/rocket/bloc/rocket_bloc.dart';
import 'package:direct_navigation/rocket/data/models/rocket_model.dart';
import 'package:direct_navigation/rocket/data/repositories/rocket_repository.dart';
import 'package:direct_navigation/rocket/presentation/screens/rocket_screen.dart';
import 'package:direct_navigation/service/ticker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
    @required this.rocketRepository,
  });

  final RocketRepository rocketRepository;

  
  final _counterBloc = CounterCubit();

  final _timerBloc = TimerBloc(ticker: Ticker());

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal[600],
        accentColor: Color.fromRGBO(72, 74, 126, 1),
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => BlocProvider.value(
              value: _counterBloc,
              child: PageA(),
            ),
        '/pageB': (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _counterBloc),
                BlocProvider.value(value: _timerBloc)
              ],
              child: PageB(),
            ),
        '/timer': (context) => BlocProvider.value(
              value: _timerBloc,
              child: Timer(),
            ),
        '/rockets': (context) => BlocProvider(
              create: (context) => RocketBloc(rocketRepository: rocketRepository),
              child: RocketScreen(),
            ),
      },
      initialRoute: '/',
    );
  }

 
}

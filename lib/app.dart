import 'package:direct_navigation/bloc/bloc.dart';
import 'package:direct_navigation/pages/page_a.dart';
import 'package:direct_navigation/pages/page_b.dart';
import 'package:direct_navigation/pages/timer.dart';
import 'package:direct_navigation/service/ticker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _counterBloc = CounterBloc();
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
        '/pageB': (context) => BlocProvider.value(
              value: _counterBloc,
              child: PageB(),
            ),
        '/timer': (context) => BlocProvider.value(
              value: _timerBloc, 
              child: Timer(),
            ),
      },
      initialRoute: '/',
    );
  }

  @override
  void dispose() {
    _counterBloc.close();
    //Necesaary?? _timerBloc.close();
    _timerBloc.close();
    super.dispose();
  }
}

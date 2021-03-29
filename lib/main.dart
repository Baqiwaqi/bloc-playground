

import 'package:direct_navigation/app.dart';
import 'package:direct_navigation/bloc/nav_bloc.dart';
import 'package:direct_navigation/cubit/counter_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers:[ 
      BlocProvider<MyBloc>(
        create: (context) => MyBloc()),
    ],
    child: MyApp(),
  ));
}

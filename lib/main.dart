import 'package:direct_navigation/bloc_observer.dart';
import 'package:direct_navigation/rocket/data/provider/rocket_api_client.dart';
import 'package:direct_navigation/rocket/data/repositories/rocket_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:direct_navigation/app.dart';
import 'package:direct_navigation/bloc/nav_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = SimpleBlocObserver();

  final RocketRepository rocketRepository = RocketRepository(
    rocketApiClient: RocketApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<MyBloc>(create: (context) => MyBloc()),
    ],
    child: MyApp(rocketRepository: rocketRepository),
  ));
}

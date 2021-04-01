import 'package:direct_navigation/rocket/bloc/rocket_bloc.dart';
import 'package:direct_navigation/rocket/presentation/widgets/rocket_list_tile.dart';
import 'package:direct_navigation/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RocketScreen extends StatefulWidget {
  @override
  _RocketScreenState createState() => _RocketScreenState();
}

class _RocketScreenState extends State<RocketScreen> {
  @override
  void initState() {
    BlocProvider.of<RocketBloc>(context).add(FetchRocketEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RocketScreen'),
      ),
      drawer: SideMenu(),
      body: Center(
        child: BlocBuilder<RocketBloc, RocketState>(
            // ignore: missing_return
            builder: (context, state) {
          if (state is RocketInitial) {
            return Center(
              child: Column(
                children: [
                  Text('Rockets need to be loaded'),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
          if (state is RocketLoadInProgres) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RocketLoadSuccess) {
            final rockets = state.rockets;
            return RocketList(rockets: rockets);
          }
        }),
      ),
    );
  }
}

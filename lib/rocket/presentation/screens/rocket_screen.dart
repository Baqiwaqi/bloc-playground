import 'package:direct_navigation/rocket/bloc/rocket_bloc.dart';
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
            return ListView.builder(
                itemCount: rockets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        rockets[index].flickrImages.first,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(rockets[index].name),
                    subtitle: Text(
                      rockets[index].description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                });
          }
        }),
      ),
    );
  }
}

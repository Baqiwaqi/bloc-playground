import 'package:direct_navigation/bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
    return BlocListener<MyBloc, MyState>(
      listener: (context, state) {
        if (state is StateB) {
          Navigator.of(context).pushNamed('/pageB');
        }
        if (state is StateTimer) {
          Navigator.of(context).pushNamed('/timer');
        }
        if (state is StateA) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }

      },
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Navigation'),
            ),
            
            ListTile(
              title: Text('PageA'),
              onTap: () {
                BlocProvider.of<MyBloc>(context).add(MyEvent.eventA);
              },
            ),
            ListTile(
              title: Text('PageB'),
              onTap: () {
                BlocProvider.of<MyBloc>(context).add(MyEvent.eventB);
              },
            ),
            ListTile(
              title: Text('Timer'),
              onTap: () {
                BlocProvider.of<MyBloc>(context).add(MyEvent.Timer);
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:direct_navigation/rocket/data/models/rocket_model.dart';
import 'package:direct_navigation/rocket/presentation/screens/rocket_detail_screen.dart';
import 'package:flutter/material.dart';

class RocketList extends StatelessWidget {
  RocketList({
    Key key,
    @required this.rockets,
  })  : assert(rockets != null),
        super(key: key);

  final List<RocketModel> rockets;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rockets.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    RocketDetailScreen(rocket: rockets[index]),
              ),
            );
          },
          leading: rockets[index].flickrImages.isEmpty
              ? null
              : AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: 'hero-${rockets[index].id}-image',
                    child: Image.network(
                      rockets[index].flickrImages.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          title: Text(rockets[index].name),
          subtitle: Text(
            rockets[index].description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(Icons.chevron_right),
        );
      },
    );
  }
}

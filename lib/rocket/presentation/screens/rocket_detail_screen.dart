import 'package:direct_navigation/rocket/data/models/rocket_model.dart';
import 'package:flutter/material.dart';

class RocketDetailScreen extends StatelessWidget {
  RocketDetailScreen({
    Key key,
    @required this.rocket,
  })  : assert(rocket != null),
        super(key: key);

  final RocketModel rocket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rocket.name),
        actions: [
          //here comes the favorited cubit;
        ],
      ),
      body: ListView(
        children: [
          _ImageHeader(rocket: rocket),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
            child: Column(
            
              children: [

                ListTile(
                  title: Text(
                    rocket.name,
                    style: TextStyle(fontSize: 40),
                  ),
                  subtitle: rocket.active ? Text('Active') : Text('Inactive'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(rocket.description),
                ),
                ListTile(
                  leading: Text(
                    rocket.company,
                    style: TextStyle(fontSize: 20),
                  ),
                  title: Text('Country: ${rocket.country}'),
                  subtitle:
                      Text('Cost per Launch: ${rocket.costPerLaunch.toString()}'),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.double_arrow_outlined),
                  title: Text('${rocket.diameter.meters}m'),
                  subtitle: Text('in diameters'),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.arrow_upward),
                  title: Text('${rocket.height.meters}m'),
                  subtitle: Text('in height'),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.line_weight),
                  title: Text('${rocket.mass.kg}kg'),
                  subtitle: Text('total mass'),
                ),
              //   ListTile(
              //     leading: Icon(Icons.line_weight),
              //     title: Text('${rocket.mass.kg}kg'),
              //     subtitle: Text('total mass'),
              //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageHeader extends StatelessWidget {
  _ImageHeader({
    Key key,
    this.rocket,
  }) : super(key: key);

  final RocketModel rocket;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Hero(
        tag: 'hero-${rocket.id}-image',
        child: PageView(children: [
          for (var url in rocket.flickrImages)
            Image.network(
              url,
              fit: BoxFit.contain,
            ),
        ]),
      ),
    );
  }
}

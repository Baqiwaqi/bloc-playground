import 'package:direct_navigation/rocket/data/models/rocket_model.dart';
import 'package:direct_navigation/rocket/data/provider/rocket_api_client.dart';
import 'package:meta/meta.dart';

class RocketRepository {
  final RocketApiClient rocketApiClient;

  RocketRepository({
    @required this.rocketApiClient,
  }) : assert(rocketApiClient != null);

  Future<List<RocketModel>> getRockets() async {
    return rocketApiClient.fetchRockets();
  }
}

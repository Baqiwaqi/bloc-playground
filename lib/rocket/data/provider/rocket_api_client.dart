import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:direct_navigation/rocket/data/models/rocket_model.dart';

class RocketApiClient {
  static const baseUrl = 'https://api.spacexdata.com/v4';
  final http.Client httpClient;

  RocketApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<RocketModel>> fetchRockets() async {
    final rocketUrl = '$baseUrl/rockets';
    final rocketResponse = await this.httpClient.get(rocketUrl);

    if (rocketResponse.statusCode != 200) {
      throw Exception('error getting rockets');
    }

    final rocketJson = jsonDecode(rocketResponse.body) as List;
    final rockets =
        rocketJson.map((json) => RocketModel.fromJson(json)).toList();

    return rockets;
  }
}


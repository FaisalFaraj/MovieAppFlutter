import 'dart:async';

import '/core/constant/api_routes.dart';
import '/core/services/http/http_service.dart';
import '/locator.dart';
import '../../models/actor/actor.dart';

abstract class ActorsRemoteDataSource {
  Future<Actor> fetchActor([Map<String, dynamic>? parameters]);

  Future<List<Actor>> fetchActorsList([Map<String, dynamic>? parameters]);
}

class ActorsRemoteDataSourceImpl implements ActorsRemoteDataSource {
  final HttpService? httpService = locator<HttpService>();

  @override
  Future<Actor> fetchActor([Map<String, dynamic>? parameters]) async {
    Map<String, dynamic> restData = await (httpService!
        .getHttp(ApiRoutes.actor(parameters!['id']), parameters));

    return Actor.fromJson(restData);
  }

  @override
  Future<List<Actor>> fetchActorsList(
      [Map<String, dynamic>? parameters]) async {
    Map<String, dynamic> jsonData =
        await httpService!.getHttp(ApiRoutes.actors, parameters);

    var list = jsonData['data'] as List<dynamic>;

    var items = list.map<Actor>((vendorMap) {
      return Actor.fromJson(vendorMap);
    }).toList();
    return items;
  }
}

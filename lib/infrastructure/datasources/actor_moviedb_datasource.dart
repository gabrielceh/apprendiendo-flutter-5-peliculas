import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDBDataSource extends ActorsDataSource {
    final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'language': 'es-MX',
    },
    headers: {
      'Authorization': 'Bearer ${Environment.tmdbToken}',
      'Content-Type': 'application/json',
    },
  ));

    List<Actor> _jsonToActors(Map<String, dynamic> json) {
    final responseCredits = CreditsResponse.fromJson(json);

    final List<Actor> actors = responseCredits.cast
      .map((actor) => ActorMapper.castToEntity(actor),)
      .toList();

    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async {
    final responseCredits = await dio.get('/movie/$movieId/credits');


    return _jsonToActors(responseCredits.data);
  }

}
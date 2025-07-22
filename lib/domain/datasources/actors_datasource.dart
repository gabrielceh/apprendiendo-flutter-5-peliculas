import 'package:cinemapedia/domain/entities/actors.dart';

abstract class ActorsDataSource {

  Future<List<Actor>> getActorsByMovieId(String movieId);


}
import 'package:cinemapedia/domain/repositories/actors_repository.dart';
import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// este repository es INMUTABLE
final actorsRepositoryProvider = Provider<ActorsRepository>((ref) {
  // llamamos al repository implementado y le pasamos el datasource que vamos a utilizar
  return ActorRepositoryImpl(ActorMovieDBDataSource());
});

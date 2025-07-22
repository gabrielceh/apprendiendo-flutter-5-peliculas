import 'package:cinemapedia/domain/repositories/movies_repository.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource_impl.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// este repository es INMUTABLE
final movieRepositoryProvider = Provider<MoviesRepository>((ref) {
  // llamamos al repository implementado y le pasamos el datasource que vamos a utilizar
  return MovieRepositoryImpl(MovieDBDataSourceImpl());
});

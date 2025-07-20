import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {

  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if(nowPlayingMovies.isEmpty) return [];

  // devolvemos una lista de las primeras 6 movies de la lista actual de movies
  return nowPlayingMovies.sublist(0, 6);

});
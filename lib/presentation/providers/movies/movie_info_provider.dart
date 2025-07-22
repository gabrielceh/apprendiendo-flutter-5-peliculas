import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =  StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref){
  final movieRepository = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(
    getMovie: movieRepository.getMovieById,
  );
});


typedef GetMovieCallback = Future<Movie> Function(String movieId);

// La idea es crear un cache, guaradando en un mapa de id: Movie la informacion de un movie
// si el id no esta en el mapa, se debe buscar en la api
// si el id esta en el mapa, se debe devolver el movie
class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie
  }) : super({});

  Future<void> loadMovie(String movieId) async{
    if(state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state  = {...state, movieId: movie};
  }
}
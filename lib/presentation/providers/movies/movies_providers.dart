import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// MoviesMotifier es el controlador -  List<Movie> es la data
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // llamamos al repository provider para obtener mas movies, el metodo getNowPlaying es el que esta en el MovieRepositoryImpl
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});


// typedef se usa para definir un alias para un tipo de función. Esto ayuda a que el código sea más legible y fácil de reutilizar
typedef MovieCallback = Future<List<Movie>> Function({int page}); 


class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]); // inicializamos el state notifier con un array vacio

  Future<void> loadNextPage() async {
    if(isLoading) return;
    isLoading = true;

    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state,...movies];
    
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

}
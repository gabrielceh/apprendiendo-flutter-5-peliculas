import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearMoviesCallback = Future<List<Movie>> Function(String query);

// esto lo estamos implementando en el custom_appbar.dart
class SearchMovieDelegate extends SearchDelegate<Movie?>{

  final SearMoviesCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debounceMovie = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast(); // nos sirve para mostrar el spinner mientras se busca
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,  
    required this.initialMovies
  });

  // cerramos los streams cuando salimos de la vista
  void clearStreams(){
    debounceMovie.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true); // apenas empezamos a buscar pasa a true
    if(_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // buscando las películas
      if(query.isEmpty) {
        debounceMovie.add([]);
        return;
      }
      final movies = await searchMovies(query);
      debounceMovie.add(movies);
      initialMovies = movies;
      isLoadingStream.add(false); // detenemos el spinner y pasamos a false
    });
  }


  // para contruir las acciones de la busqueda
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
        StreamBuilder(
          initialData: false, // valor inicial del isLoadingStream
          stream: isLoadingStream.stream, 
          builder: (context, snapshot){
            if(snapshot.data ?? false){
              // si es true, mostramos el spinner
              return  SpinPerfect(
                duration: const Duration(seconds: 2),
                spins: 10,
                infinite: true,
                child: IconButton(
                  // query es la variable que almacena el texto que se escribe en la busqueda, está dentro de la clase SearchDelegate
                  onPressed: ()=> query = '',
                  icon: const Icon(Icons.refresh_rounded),
                ),
              );
            }
            return  FadeIn(
              animate: query.isNotEmpty,
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                // query es la variable que almacena el texto que se escribe en la busqueda, está dentro de la clase SearchDelegate
                onPressed: ()=> query = '',
                icon: const Icon(Icons.clear_outlined),
              ),
            );
            
          }
        ),
      

   
    ];
  }

  // para construir la parte de la izquierda de la busqueda
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      // close es una funcion que cierra la busqueda dentro del SearchDelegate
      onPressed: (){
         clearStreams();
         close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }


  Widget _buildResultsAndSuggestions() {
    return StreamBuilder(
      stream: debounceMovie.stream,
      initialData: initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return _MovieSearchItem(
              movie:  movie, 
              onMovieSelected: (context,movie){
                close(context, movie);
                clearStreams();
            },);
          }
        );
      },
    );
  }
  // para mostrar resultados de la busqueda cuando la persona presiona enter
  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsAndSuggestions();
  }

  // cuando la persona escribe algo en la busqueda, mostrar resultados previos
  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);

    return _buildResultsAndSuggestions();
  }

  // para mostrar el placeholder de la busqueda
  @override
  String get searchFieldLabel => 'Buscar película';
}

class _MovieSearchItem extends StatelessWidget {
  final Movie movie;
  final Function(BuildContext, Movie) onMovieSelected; // funcion para ir a la pelicula

  const _MovieSearchItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return  GestureDetector(
      onTap: () {
        // vamos a la pelicula
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath, 
                  loadingBuilder: (context, child, loadingProgress){
      
                    return FadeIn(child: child);
                  },
                ),
              )
            ),
      
            SizedBox(width: 10),
      
            SizedBox(
              width: size.width * 0.7,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  SizedBox(height: 5),
                  Text(
                    movie.overview, style: textStyles.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 5),
                      Text(movie.voteAverage.toStringAsFixed(1), style: textStyles.bodyMedium!.copyWith(color: Colors.amber.shade700)),
                    ],
                  )
                ],
              )
            )
          ],
        )
      ),
    );
  }
}

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/search/search_movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  

  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;


    return SafeArea(
      // bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10 ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.local_movies_outlined, color:colors.primary),
              const SizedBox(width: 5),
              Text('CinemaPedia', style: titleStyle?.copyWith(color: colors.primary) ),

              Spacer(),

              IconButton(
                onPressed: () {
                  final searchMovies = ref.read(searchedMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  // puede que la persona seleccione una película para verla o no
                  showSearch<Movie?>(
                    query: searchQuery,
                    context: context, 
                    // delegate es el encargado de trabajar la busqueda
                    // delegate: SearchMovieDelegate(searchMovies: moviesRepo.searchMovie),
                    delegate: SearchMovieDelegate(
                      initialMovies: searchMovies,
                      searchMovies: (query){
                        // mantenemos el estado de la búsqueda
                        ref.read(searchQueryProvider.notifier).state = query;
                        return ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery(query);
                      }),
                  ).then((movie){ // si queremos ir al detalle de una película
                    if(movie != null && context.mounted){
                      // si la persona selecciona una película, vamos a la película detallada
                      // context.push('/movie/${movie.id}');
                      context.push('/home/0/movie/${movie.id}');
                    }
                  });
                 

                },
                icon: const Icon(Icons.search_outlined),
              )
            ],
          )
        )
      )
    );
  }
}
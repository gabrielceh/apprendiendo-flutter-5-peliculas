import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  //  ahora el createState() es una instancia de HomeViewState
  @override
  HomeViewState createState() => HomeViewState();
}

// nuestra clase ahoa exttiende de ConsumerState que nos permite acceder al ref
class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();
    // cuando se inicia la app, cargamos los povider para que hagan las peticiones
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesPRovider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesPRovider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);


    return Visibility(
      visible: !initialLoading,
      replacement: const FullScreenLoader(),
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppBar(),
              titlePadding: EdgeInsets.only(left: 0),
            ),
            
          ),
      
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index){
                return Column(
                  children: [
                    MoviesSlideshow(movies: moviesSlideshow),
                
                    MoviesHorizontalListview(
                      movies: nowPlayingMovies,
                      title: 'En cines',
                      subtitle: 'Hoy',
                      loadNextPage: (){
                        ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                      },
                    ),
                  
                    MoviesHorizontalListview(
                      movies: popularMovies,
                      title: 'Populares',
                      loadNextPage: (){
                        ref.read(popularMoviesProvider.notifier).loadNextPage();
                      },
                    ),
                    
                    MoviesHorizontalListview(
                      movies: upcomingMovies,
                      title: 'Próximos estrenos',
                      subtitle: 'Pronto',
                      loadNextPage: (){
                        ref.read(upcomingMoviesPRovider.notifier).loadNextPage();
                      },
                    ),
                    
                    MoviesHorizontalListview(
                      movies: topRatedMovies,
                      title: 'Mejor calificados',
                      subtitle: 'De todos los tiempos',
                      loadNextPage: (){
                        ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                      },
                    ),
      
                    SizedBox(height: 20),
                  ]
                );
              }
            )
          )
        ]
      ),
    );
  }
}


 
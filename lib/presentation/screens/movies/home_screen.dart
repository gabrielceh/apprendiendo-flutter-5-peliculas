import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = 'home-screen';
  

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _HomeView(),
      ),

      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}

// nuestra clase ahoa exttiende de ConsumerStatefulWidget
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  //  ahora el createState() es una instancia de _HomeViewState
  @override
  _HomeViewState createState() => _HomeViewState();
}

// nuestra clase ahoa exttiende de ConsumerState que nos permite acceder al ref
class _HomeViewState extends ConsumerState<_HomeView> {

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
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesPRovider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    if (moviesSlideshow.isEmpty) {
      return CircularProgressIndicator();
    }

    return CustomScrollView(
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
            childCount: 4,
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
            },
            
          )
        )
      ]
    );
  }
}

/**
 Column(
        children: [
          CustomAppBar(),
      
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
            movies: nowPlayingMovies,
            title: 'Proximos estrenos',
            subtitle: 'Pronto',
            loadNextPage: (){
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            },
          ),
          
          MoviesHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Populares',
            loadNextPage: (){
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            },
          ),
          
          MoviesHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Mejor calificados',
            subtitle: 'De todos los tiempos',
            loadNextPage: (){
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            },
          ),

          SizedBox(height: 20),
        ]
      ),
 */
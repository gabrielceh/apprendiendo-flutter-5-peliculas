import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    // iniciamos el provider con las primeras peliculas
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies = await ref
        .read(favoriteMoviesProvider.notifier)
        .loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // convertimos el mapa en una lista de movies(alues) para poder acceder a los elementos
    final movies = ref.watch(favoriteMoviesProvider).values.toList();

    if (movies.isEmpty) {
      final color = Theme.of(context).colorScheme;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, color: color.primary, size: 60),
            Text(
              '¡Ohhh no!',
              style: TextStyle(color: color.primary, fontSize: 30),
            ),
            Text(
              '¡No tienes ninguna pelicula favorita! 😥',
              style: TextStyle(color: Colors.black54, fontSize: 20),
            ),

            SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => context.push('/home/0'),
              child: Text('Empieza a buscar'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Favoritas')),
      body: MovieMasonry(movies: movies, loadNextPage: loadNextPage),
    );
  }
}

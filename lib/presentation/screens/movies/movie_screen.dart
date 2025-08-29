import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const String routeName = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    // recordar que widget es el widget actual (MovieScreen) y por eso podemos acceder al movieId
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) return Scaffold(body: const FullScreenLoader());

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => _MovieDetails(movie: movie),
            ),
          ),
        ],
      ),
    );
  }
}

// FuturtProvider permite trabajar con tareas asíncronas
// family permite que el provider reciba un argumento, en este caso el movieId como int
// Esto puede estar en su propio archio
final isFavoriteProvider = FutureProvider.family.autoDispose<bool, int>((
  ref,
  int movieId,
) async {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieInFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavFuture = ref.watch(
      isFavoriteProvider(movie.id),
    ); // le pasamos el movieId como argumento

    final size = MediaQuery.of(
      context,
    ).size; // obtenemos la altura y anchura de la pantalla

    return SliverAppBar(
      actions: [
        IconButton(
          onPressed: () async {
            // ref.read(localStorageRepositoryProvider)
            // .toggleFavorite(movie)
            // .then((_){
            //   ref.invalidate(isFavoriteProvider(movie.id)); // invalidamos el provider para que se actualice
            // });
            await ref
                .read(favoriteMoviesProvider.notifier)
                .toggleFavorite(movie);
            ref.invalidate(
              isFavoriteProvider(movie.id),
            ); // invalidamos el provider para que se actualice
          },
          icon: isFavFuture.when(
            loading: () => const CircularProgressIndicator(),
            data: (isFav) => isFav
                ? Icon(Icons.favorite, color: Colors.red)
                : Icon(Icons.favorite_border),
            error: (_, _) =>
                throw UnimplementedError(), // no implementamos nada en caso de error por pereza
          ),

          // Icon(Icons.favorite_border),
          // icon:  Icon(Icons.favorite, color: Colors.red),
        ),
      ],
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7, // ocupamos el 70% de la pantalla
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        // titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(color: Colors.white, fontSize: 20),
        //   textAlign: TextAlign.start,
        //   maxLines: 2,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: FadeIn(
                child: CustomCacheImageNetwork(
                  imageUrl: movie.posterPath,
                  width: size.width,
                ),
              ),
            ),

            const _CustomGradient(
              colors: [Colors.transparent, Colors.black87],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.65, 1.0],
            ),
            const _CustomGradient(
              colors: [Colors.transparent, Colors.black87],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [
                0.80,
                1.0,
              ], // dependiendo de la cantidad de colores, primer elemento para el primer color, etc
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(
      context,
    ).size; // obtenemos la altura y anchura de la pantalla
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CustomCacheImageNetwork(
                  imageUrl: movie.posterPath,
                  width: size.width * 0.3,
                  height: size.height * 0.225,
                ),
              ),

              const SizedBox(width: 10),

              // Información
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyle.titleLarge,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 10),
                    Text(movie.overview),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Generos
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map(
                (gender) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(
                      gender.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: colors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Actores
        _ActorsByMovie(movieId: movie.id.toString()),

        const SizedBox(height: 50),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return Center(child: const CircularProgressIndicator());
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 320,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CustomCacheImageNetwork(
                      imageUrl: actor.profilePath,
                      width: 135,
                      height: 180,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  actor.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    required this.begin,
    required this.end,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: begin,
            end: end,
            stops:
                stops, // dependiendo de la cantidad de colores, primer elemento para el primer color, etc
          ),
        ),
      ),
    );
  }
}

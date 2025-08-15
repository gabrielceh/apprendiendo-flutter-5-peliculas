import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_cache_image_network.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;

  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GestureDetector(
        onTap: () => context.go('/home/2/movie/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeIn(
            child: CustomCacheImageNetwork(
              imageUrl: movie.posterPath,
              height: 220,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;

  const MoviePosterLink({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GestureDetector(
        onTap: () => context.go('/home/2/movie/${movie.id}'), 
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeIn(
            child: Image.network(
              movie.posterPath,
              loadingBuilder: (context, child, loadingProgress){
                if(loadingProgress != null){
                  return Pulse(
                    duration: const Duration(milliseconds: 1000),
                    infinite: true,
                    child: Container(
                      height: 220,
                      color: Colors.black12,
                    ),
                  );
                }
                return child;
              },
            ),
          )
        ),
      ),
    );
  }
}
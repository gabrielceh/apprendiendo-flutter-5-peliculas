import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {

  final List<Movie> movies;
  

  const MoviesSlideshow({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,
      // pub add card_swiper
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary.withAlpha(60),
            size: 10,
          )
        ),
        itemCount: movies.length,
        itemBuilder: (context, index){
          return _Slide(movie: movies[index]);
        },
      )
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const[
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset:  Offset(0, 10),
        )
      ]
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: _ImageSlideshow(movie: movie)
        )
      ),
    );
  }
}

class _ImageSlideshow extends StatelessWidget {
  final Movie movie;

  const _ImageSlideshow({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(child: Stack(
            children: [    
              CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: movie.backdropPath,
                placeholder: (_,_){
                  return const DecoratedBox(
                    decoration: BoxDecoration( 
                      color: Colors.black12
                    ),
                  );
                },
                errorWidget: (_,_,error){
                  print('error: $error');
                  return Image.asset('assets/images/no-image.png');
                },
              ),

              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.65, 1.0], // depeneden de la cantidad de colores, primer elemento para el primer color, etc
                      colors: [ Colors.transparent, Colors.black87],
                    ),
                  ),
                )
              ),
    
              Positioned(
                bottom: 10,
                right: 15,
                child: SizedBox(
                  width: 300,
                  child: Text(
                    movie.title,
                    textAlign: TextAlign.right, 
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, 
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                )
            ),
          ])
        );
        
      
  }
}

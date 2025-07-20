import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviesHorizontalListview extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListview({
    super.key,
    required this.movies,  
    this.title, 
    this.subtitle,
    this.loadNextPage,
  });

  @override
  State<MoviesHorizontalListview> createState() => _MoviesHorizontalListviewState();
}

class _MoviesHorizontalListviewState extends State<MoviesHorizontalListview> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if(widget.loadNextPage == null) return;
    // siempr, despues de añadir un listener, hacemos el dispose
    scrollController.addListener(() {
      if((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Column(
        children: [
          if(widget.title != null || widget.subtitle != null) 
            _Title(title: widget.title, subtitle: widget.subtitle),
          
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index){
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            )
          ),
          

        ],
      )
    );
  }
}

class _Title extends StatelessWidget {
  
  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child:Row(
        children: [
          if(title != null) 
            Text(title!, style: titleStyle.titleLarge),
          const Spacer(),
          if(subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subtitle!),
            ),
          
        ],
      )
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle  = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child:ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: _ImageCardMovie(movie: movie),
            ),
          ),
          
          SizedBox(height: 5,),
          // title
          SizedBox(width: 150, 
           child: Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle.titleSmall,
            ),
          ),
          // Rating
          _FotterMovieHorizontal(movie: movie, textStyle: textStyle)

        ],
      ),
    );
  }
}

class _ImageCardMovie extends StatelessWidget {
  const _ImageCardMovie({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      movie.posterPath,
      fit: BoxFit.cover,
      height: 225,
      width: 150,
      loadingBuilder: (context, child, loadingProgress){
        if (loadingProgress != null){
          return SizedBox(
            height: 225,
            child: Center(
              child: const CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        }
          return GestureDetector(
            onTap: (){
              context.push('/movie/${movie.id}');
            },
            child: FadeIn(child: child),
          );

      },
    );
  }
}

class _FotterMovieHorizontal extends StatelessWidget {
  const _FotterMovieHorizontal({
    required this.movie,
    required this.textStyle,
  });

  final Movie movie;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children:[
            Icon(Icons.star_outlined, color: Colors.amber.shade800),
            const SizedBox(width: 5),
            Text(movie.voteAverage.toStringAsFixed(1), style: textStyle.bodyMedium?.copyWith(color: Colors.amber.shade800)),
            // const SizedBox(width: 10),
            Spacer(),
            Text(HumanFormats.number(movie.popularity), style: textStyle.bodySmall),
          ]
        ),
      ),
    );
  }
}
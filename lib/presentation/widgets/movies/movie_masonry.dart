import 'package:flutter/material.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';

class MovieMasonry extends StatefulWidget {

  final List<Movie> movies;
  final VoidCallback? loadNextPage;
  

  const MovieMasonry({
    super.key,
    required this.movies,
    this.loadNextPage,
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  // llamamos al scrollController para poder controlar el scroll
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // validamos si viene la funcion para cargar mas paginas
    if(widget.loadNextPage == null) return;
    isLoading = true;
    scrollController.addListener((){
      if(scrollController.position.pixels + 100 >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }
    });
    isLoading = false;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3, // columnas
        mainAxisSpacing: 10, // espacio entre columnas
        crossAxisSpacing: 10, // espacio entre filas
        itemCount: widget.movies.length,
        itemBuilder: (context, index){
          // opcional, solo para que se vea como un masonry
          if(index == 1 ){
            return Column(
              children: [
              const SizedBox(height: 40),
              MoviePosterLink(movie: widget.movies[index])
            ],);
          }
          return MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/models_moviedb.dart';



class MovieMapper {

  static Movie movieDBToEntity(MovieFromMovieDB movieDB){
    final String imageURL = 'https://image.tmdb.org/t/p/original';
    final String imageNotFound = 'https://cdn.displate.com/artwork/857x1200/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg';

    return Movie(
      adult: movieDB.adult,
      backdropPath: movieDB.backdropPath != "" ? '$imageURL${movieDB.backdropPath}' : imageNotFound,
      genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: movieDB.posterPath != "" ? '$imageURL${movieDB.posterPath}' : 'no-poster',
      releaseDate: movieDB.releaseDate,
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount,
    );
  }

}
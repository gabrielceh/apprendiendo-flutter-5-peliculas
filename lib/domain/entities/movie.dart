import 'package:isar/isar.dart';

// esto genera un archivo de código para el modelo
part 'movie.g.dart';


@collection // esto viene de isar
class Movie {
  // Id isarId = Isar.autoIncrement; // identificador de la base de datos auto incremental
  Id? isarId;

  final bool adult;
  final String backdropPath;
  final String budget;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount
  });
}
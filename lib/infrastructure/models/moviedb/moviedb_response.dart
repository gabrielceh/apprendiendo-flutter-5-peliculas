import 'package:cinemapedia/infrastructure/models/moviedb/movie_from_moviedb.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_dates.dart';

class MovieDbResponse {
    final MovieDbDates? dates;
    final int page;
    final List<MovieFromMovieDB> results;
    final int totalPages;
    final int totalResults;

    MovieDbResponse({
        this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory MovieDbResponse.fromJson(Map<String, dynamic> json) => MovieDbResponse(
        dates: json["dates"] != null ? MovieDbDates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MovieFromMovieDB>.from(json["results"].map((x) => MovieFromMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}



import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/models_moviedb.dart';
import 'package:dio/dio.dart';

class MovieDBDataSourceImpl extends MoviesDataSource{
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'language': 'es-MX',
    },
    headers: {
      'Authorization': 'Bearer ${Environment.tmdbToken}',
      'Content-Type': 'application/json',
    },
  ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing', 
      queryParameters: {'page': page.toString()}
    );

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
      .where((movie) => movie.posterPath != 'no-poster') // filtrar las movies que no tienen poster
      .map((moviedb) => MovieMapper.movieDBToEntity(moviedb),)
      .toList();


    return movies;
  
  }
}
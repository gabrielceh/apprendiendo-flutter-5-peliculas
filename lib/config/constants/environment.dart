import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static  String tmdbToken = dotenv.env['TMDB_TOKEN'] ?? 'no hay token';
  static  String tmdbApi = dotenv.env['TMDB_API'] ?? 'no hay api key';
}
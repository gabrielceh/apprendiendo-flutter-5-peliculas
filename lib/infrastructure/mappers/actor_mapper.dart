import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast){
    final String imageURL = 'https://image.tmdb.org/t/p/original';

    return Actor(
      id: '$cast.id',
      name: cast.name,
      profilePath: cast.profilePath != null 
        ? '$imageURL${cast.profilePath}' 
        : 'https://i.pinimg.com/originals/2c/47/d5/2c47d5dd5b532f83bb55c4cd6f5bd1ef.jpg',
      character: cast.character,
    );
  }
}
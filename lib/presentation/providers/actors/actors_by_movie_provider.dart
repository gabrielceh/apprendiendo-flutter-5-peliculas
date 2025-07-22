import 'package:cinemapedia/domain/entities/actors.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorByMovieProvider =  StateNotifierProvider<ActorByMovieMapNotifier, Map<String, List<Actor>>>((ref){
  final actorRepository = ref.watch(actorsRepositoryProvider);

  return ActorByMovieMapNotifier(
    getActor: actorRepository.getActorsByMovieId,
  );
});


typedef GetActorCallback = Future<List<Actor>> Function(String movieId);

// La idea es crear un cache, guaradando en un mapa de id: Actor la informacion de un actor
// si el id no esta en el mapa, se debe buscar en la api
// si el id esta en el mapa, se debe devolver el actor
class ActorByMovieMapNotifier extends StateNotifier<Map<String, List<Actor>>> {

  final GetActorCallback getActor;

  ActorByMovieMapNotifier({
    required this.getActor
  }) : super({});

  Future<void> loadActors(String movieId) async{
    if(state[movieId] != null) return;

    final actors = await getActor(movieId);

    state  = {...state, movieId: actors};
  }
}
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource  extends LocalStorageDatasource{
  // creamos la instancia de Isar
  late Future<Isar> db;

  IsarDatasource() {
    db=openDB();
  }

  Future<Isar> openDB() async {
    // getApplicationDocumentsDirectory() nos devuelve la ruta de la carpeta de datos de la aplicación, iene de path_provider
    final dir = await getApplicationDocumentsDirectory();
    // validamos que no tengamos instancias de Isar
    if(Isar.instanceNames.isEmpty){
      // creamos la instancia de Isar con el directorio de datos de la aplicación
      // le pasamos los esquemas que creamos con el buil de isar
      return Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieInFavorite(int movieId) async{
    final isar = await db;

    final Movie? movieIsInFav = await isar.movies
    .filter()
    .idEqualTo(movieId)
    .findFirst(); // idEqual viene del id de la movie, si se llamara movieId seria movieIdEqualTo

    return movieIsInFav != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async{
    final isar = await db;

    return isar.movies.where().offset(offset).limit(limit).findAll();
  }


  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;
    final favoriteMovie = await isar.movies.filter().idEqualTo(movie.id).findFirst();

    // si  existe el movie en la base de datos, lo borramos
    if(favoriteMovie != null){
      isar.writeTxnSync(()=> isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }

    // insertamos el movie en la base de datos
    isar.writeTxnSync(()=> isar.movies.putSync(movie));
  }
}
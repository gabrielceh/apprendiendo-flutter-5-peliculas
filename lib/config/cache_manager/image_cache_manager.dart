import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCacheManager extends CacheManager {
  static const key = 'imageCacheKey';

  ImageCacheManager(super.config);

  static CacheManager getInstance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 30), // Tiempo en caché
      maxNrOfCacheObjects: 100,
      fileSystem: IOFileSystem(key),
      fileService: HttpFileService(),
    ),
  );
}

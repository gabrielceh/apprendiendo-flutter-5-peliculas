import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinemapedia/config/cache_manager/image_cache_manager.dart';
import 'package:flutter/material.dart';

class CustomCacheImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const CustomCacheImageNetwork({
    super.key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: ImageCacheManager.getInstance,
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => Pulse(
        duration: const Duration(milliseconds: 1000),
        infinite: true,
        child: Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/image-not-found.png',
            ), // Tu imagen de error
            fit: fit,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticlePreviewImage extends StatelessWidget {
  final String imageUrl;

  const ArticlePreviewImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Image.asset(
        'assets/image_base.jpg',
        fit: BoxFit.cover,
      ),
      imageBuilder: (context, imageProvider) => Image(
        alignment: Alignment.topCenter,
        image: imageProvider,
        fit: BoxFit.cover,
      ),
      fit: BoxFit.cover,
    );
  }
}

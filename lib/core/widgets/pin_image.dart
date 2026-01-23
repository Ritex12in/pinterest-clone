import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../features/feed/data/models/pexels_photo.dart';

class PinImage extends StatelessWidget {
  final PexelsPhoto photo;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const PinImage({
    super.key,
    required this.photo,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final aspectRatio = photo.width / photo.height;
    final bgColor = _hexToColor(photo.avgColor);

    Widget image = AspectRatio(
      aspectRatio: aspectRatio,
      child: CachedNetworkImage(
        imageUrl: photo.imageUrl,
        fit: fit,
        placeholder: (context, url) => Container(
          color: bgColor,
        ),
        fadeInDuration: const Duration(milliseconds: 200),
      ),
    );

    if (borderRadius != null) {
      image = ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return image;
  }

  Color _hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../features/feed/data/models/pexels_photo.dart';
import '../router/app_routes.dart';

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

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.push(AppRoutes.pinDetail(photo.id), extra: photo);
          },
          child: Hero(
            tag: 'pin_${photo.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: image,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {
              _openPinOptions(context, photo);
            },
            child: Icon(Icons.more_horiz),
          ),
        ),
      ],
    );
  }

  void _openPinOptions(BuildContext context, PexelsPhoto photo) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return _PinOptionsBottomSheet(photo: photo);
      },
    );
  }

  Color _hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class _PinOptionsBottomSheet extends StatelessWidget {
  final PexelsPhoto photo;

  const _PinOptionsBottomSheet({required this.photo});

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).scaffoldBackgroundColor;
    final sheetHeight = MediaQuery.of(context).size.height * 0.6;

    return SafeArea(
      child: SizedBox(
        height: sheetHeight,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned.fill(
              top: 60,
              child: Container(
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 90),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "This Pin is inspired by your recent activity",
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Expanded(
                      child: ListView(
                        children: const [
                          _OptionTile(icon: Icons.push_pin, text: "Save"),
                          _OptionTile(icon: Icons.share, text: "Share"),
                          _OptionTile(
                            icon: Icons.download,
                            text: "Download image",
                          ),
                          _OptionTile(
                            icon: Icons.search,
                            text: "See more like this",
                          ),
                          _OptionTile(
                            icon: Icons.visibility_off,
                            text: "See less like this",
                          ),
                          _OptionTile(icon: Icons.flag, text: "Report Pin"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: photo.imageUrl,
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 70,
              left: 16,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => Navigator.pop(context),
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Icon(Icons.close, color: Colors.white, size: 32),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const _OptionTile({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
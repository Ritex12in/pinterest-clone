import 'dart:async';
import 'package:flutter/material.dart';

import '../../../feed/data/models/pexels_photo.dart';

class FeaturedCarousel extends StatefulWidget {
  final List<PexelsPhoto> photos;
  final double height;
  final Duration autoScrollDuration;

  const FeaturedCarousel({
    super.key,
    required this.photos,
    this.height = 260,
    this.autoScrollDuration = const Duration(seconds: 3),
  });

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    _timer = Timer.periodic(widget.autoScrollDuration, (_) {
      if (!_controller.hasClients || widget.photos.isEmpty) return;

      _index = (_index + 1) % widget.photos.length;
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.photos.isEmpty) return const SizedBox();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.photos.length,
            onPageChanged: (i) {
              setState(() => _index = i);
            },
            itemBuilder: (context, index) {
              final photo = widget.photos[index];

              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    photo.imageUrl,
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 140,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black87,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          photo.alt.isNotEmpty ? photo.alt : "Featured",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "by ${photo.author}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.photos.length, (i) {
            final active = i == _index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: active ? 10 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: active ? Colors.white : Colors.white38,
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        ),
      ],
    );
  }
}


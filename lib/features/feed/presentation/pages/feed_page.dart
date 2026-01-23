import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/pin_image.dart';
import '../../data/models/pexels_photo.dart';
import '../controller/feed_controller.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(),
            Expanded(child: _FeedGrid()),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "For you",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 54,
                height: 3,
                decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeedGrid extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = ref.watch(feedControllerProvider);

    return feed.when(
      loading: () => _AnimatedShimmerGrid(),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (photos) {
        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(feedControllerProvider.notifier).refresh();
          },
          child: NotificationListener<ScrollNotification>(
            onNotification: (scroll) {
              if (scroll.metrics.pixels > scroll.metrics.maxScrollExtent - 500) {
                ref.read(feedControllerProvider.notifier).loadMore();
              }
              return false;
            },
            child: MasonryGridView.count(
              padding: const EdgeInsets.all(8),
              physics: const AlwaysScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
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
                          child: PinImage(
                            photo: photo,
                            borderRadius: BorderRadius.circular(16),
                          ),
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
              },
            ),
          ),
        );
      },
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
}

class _AnimatedShimmerGrid extends StatefulWidget {
  const _AnimatedShimmerGrid();

  @override
  State<_AnimatedShimmerGrid> createState() => _AnimatedShimmerGridState();
}

class _AnimatedShimmerGridState extends State<_AnimatedShimmerGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: MasonryGridView.count(
        padding: const EdgeInsets.all(8),
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: Colors.grey.shade700,
            child: Container(
              height: 200 + (index % 3) * 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          );
        },
      ),
    );
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

class _AnimatedShimmerItem extends StatefulWidget {
  final double height;
  final int index;

  const _AnimatedShimmerItem({required this.height, required this.index});

  @override
  State<_AnimatedShimmerItem> createState() => _AnimatedShimmerItemState();
}

class _AnimatedShimmerItemState extends State<_AnimatedShimmerItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    Future.delayed(Duration(milliseconds: widget.index * 80), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade800,
        highlightColor: Colors.grey.shade700,
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

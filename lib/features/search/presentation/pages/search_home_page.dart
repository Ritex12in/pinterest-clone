import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest_clone/features/search/presentation/widgets/featured_carousel.dart';

import '../../../../core/router/app_routes.dart';
import '../../../pin_detail/presentation/pages/pin_detail_page.dart';
import '../controller/search_home_controller.dart';

class SearchHomePage extends ConsumerWidget {
  const SearchHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchHomeControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(e.toString())),
          data: (data) {
            return Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: FeaturedCarousel(
                        photos: data.featured,
                        height: 360,
                      ),
                    ),

                    ...data.sections.entries.map((entry) {
                      return SliverToBoxAdapter(
                        child: _SearchSectionCard(
                          title: entry.key,
                          images: entry.value,
                          onTap: () {
                            context.push(AppRoutes.searchResults(entry.key));
                          },
                        ),
                      );
                    }),
                  ],
                ),

                const Positioned(
                  top: 12,
                  left: 0,
                  right: 0,
                  child: _SearchBar(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () {
          context.push(AppRoutes.searchInput());
        },
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              Icon(Icons.search, color: Colors.white70),
              SizedBox(width: 12),
              Text(
                "Search for ideas",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              Spacer(),
              Icon(Icons.camera_alt_outlined, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchSectionCard extends StatelessWidget {
  final String title;
  final List<String> images;
  final VoidCallback onTap;

  const _SearchSectionCard({
    required this.title,
    required this.images,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CircleButton(
                icon: Icons.search,
                onTap: onTap,
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.network(images[0], fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: Image.network(images[1], fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: Image.network(images[2], fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: Image.network(images[3], fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest_clone/features/search/presentation/widgets/featured_carousel.dart';

import '../../../../core/router/app_routes.dart';
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
    final bg = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () {
          context.push(AppRoutes.searchInput());
        },
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: bg.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(Icons.search, color: textColor?.withValues(alpha: 0.6)),
              SizedBox(width: 12),
              Text(
                "Search for ideas",
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              Icon(Icons.camera_alt_outlined, color: textColor?.withValues(alpha: 0.6)),
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
              _CircleButton(
                icon: Icons.search,
                onTap: onTap,
              ),
            ],
          ),
          const SizedBox(height: 8),
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

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return Material(
      color: textColor?.withValues(alpha: 0.15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        customBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Center(child: Icon(Icons.search, color: textColor)),
        ),
      ),
    );
  }
}

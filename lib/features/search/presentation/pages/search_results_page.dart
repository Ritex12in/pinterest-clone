import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/widgets/pin_image.dart';
import '../controller/search_results_controller.dart';

class SearchResultsPage extends ConsumerWidget {
  final String query;

  const SearchResultsPage({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(searchResultsControllerProvider(query));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _SearchBar(query: query),
            Expanded(
              child: results.when(
                loading: () => _buildShimmer(),
                error: (e, _) => Center(child: Text(e.toString())),
                data: (photos) {
                  return MasonryGridView.count(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      final photo = photos[index];

                      if (index == photos.length - 6) {
                        ref
                            .read(searchResultsControllerProvider(query)
                            .notifier)
                            .loadMore();
                      }

                      return PinImage(
                        photo: photo,
                        borderRadius: BorderRadius.circular(16),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return MasonryGridView.count(
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 200 + (index % 3) * 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  final String query;

  const _SearchBar({required this.query});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          context.push(AppRoutes.searchInput(initialQuery: query));
        },
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.white70),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  query,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



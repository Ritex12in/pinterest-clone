import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_clone/features/pin_detail/presentation/widgets.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/widgets/pin_image.dart';
import '../../../feed/data/models/pexels_photo.dart';
import '../controller/related_feed_controller.dart';

class PinDetailPage extends StatelessWidget {
  final PexelsPhoto photo;

  const PinDetailPage({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final relatedQuery = buildRelatedQuery(photo);
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Hero(
                        tag: 'pin_${photo.id}',
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: photo.imageUrl,
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                            Positioned(
                              bottom: 12,
                              right: 12,
                              child: AnimatedSearchButton(
                                onTap: () {
                                  _openRelatedBottomSheet(
                                    context,
                                    relatedQuery,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        _IconText(Icons.favorite_border, "95"),
                        const SizedBox(width: 16),
                        _IconText(Icons.chat_bubble_outline, "5"),
                        const SizedBox(width: 16),
                        const Icon(Icons.share_outlined),
                        const SizedBox(width: 16),
                        const Icon(Icons.more_horiz),
                        const Spacer(),
                        _SaveButton(),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "😮😮👍👍👍👍👍 ...",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "View all comments",
                          style: TextStyle(
                            color: textColor?.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "More to explore",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: _RelatedGrid(query: relatedQuery)),
              ],
            ),

            Positioned(
              top: 8,
              left: 16,
              child: FloatingActionButton(
                onPressed: () => Navigator.pop(context),
                backgroundColor: Colors.white.withValues(alpha: 0.6),
                elevation: 0,
                child: Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openRelatedBottomSheet(BuildContext context, String query) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return RelatedBottomSheet(query: query);
      },
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IconText(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(children: [Icon(icon), const SizedBox(width: 4), Text(text)]);
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: () {},
      child: const Text(
        "Save",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _RelatedGrid extends ConsumerStatefulWidget {
  final String query;
  final bool scrollable;

  const _RelatedGrid({required this.query, this.scrollable = false});

  @override
  ConsumerState<_RelatedGrid> createState() => _RelatedGridState();
}

class _RelatedGridState extends ConsumerState<_RelatedGrid> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();

    _controller.addListener(() {
      if (!_controller.hasClients) return;

      final max = _controller.position.maxScrollExtent;
      final offset = _controller.offset;

      if (offset > max - 300) {
        ref.read(relatedFeedProvider(widget.query).notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final related = ref.watch(relatedFeedProvider(widget.query));

    return related.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) =>
          Padding(padding: const EdgeInsets.all(16), child: Text(e.toString())),
      data: (photos) {
        return MasonryGridView.count(
          controller: _controller,
          padding: const EdgeInsets.all(8),
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: photos.length,
          shrinkWrap: !widget.scrollable,
          physics: widget.scrollable
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final photo = photos[index];
            return PinImage(
              photo: photo,
              borderRadius: BorderRadius.circular(16),
            );
          },
        );
      },
    );
  }
}

class RelatedBottomSheet extends StatelessWidget {
  final String query;

  const RelatedBottomSheet({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.search),
                const SizedBox(width: 8),
                Text(
                  "Related ideas",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          Expanded(child: _RelatedGrid(query: query, scrollable: true)),
        ],
      ),
    );
  }
}

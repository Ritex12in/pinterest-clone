import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../feed/data/models/pexels_photo.dart';
import '../../../feed/data/datasource/pexels_remote_datasource.dart';
import '../../../feed/data/repository/feed_repository_impl.dart';
import 'package:dio/dio.dart';

final relatedFeedProvider = StateNotifierProvider.family<
    RelatedFeedController,
    AsyncValue<List<PexelsPhoto>>,
    String>((ref, query) {
  final dio = Dio();
  final remote = PexelsRemoteDataSource(dio);
  final repo = FeedRepositoryImpl(remote);
  return RelatedFeedController(repo, query);
});

class RelatedFeedController
    extends StateNotifier<AsyncValue<List<PexelsPhoto>>> {
  final FeedRepositoryImpl repo;
  final String query;

  int _page = 1;
  bool _loadingMore = false;

  RelatedFeedController(this.repo, this.query)
      : super(const AsyncLoading()) {
    loadInitial();
  }

  Future<void> loadInitial() async {
    try {
      final photos = await repo.search(query, _page);
      state = AsyncData(photos);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadMore() async {
    if (_loadingMore) return;
    _loadingMore = true;
    _page++;

    final current = state.value ?? [];
    final more = await repo.search(query, _page);

    state = AsyncData([...current, ...more]);
    _loadingMore = false;
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../feed/data/datasource/pexels_remote_datasource.dart';
import '../../../feed/data/models/pexels_photo.dart';
import '../../../feed/data/repository/feed_repository_impl.dart';

final searchResultsControllerProvider = StateNotifierProvider.family<
    SearchResultsController,
    AsyncValue<List<PexelsPhoto>>,
    String>((ref, query) {
  final dio = Dio();
  final remote = PexelsRemoteDataSource(dio);
  final repo = FeedRepositoryImpl(remote);
  return SearchResultsController(repo, query);
});

class SearchResultsController
    extends StateNotifier<AsyncValue<List<PexelsPhoto>>> {
  final FeedRepositoryImpl repo;
  final String query;

  int _page = 1;
  bool _isLoadingMore = false;

  SearchResultsController(this.repo, this.query)
      : super(const AsyncLoading()) {
    loadInitial();
  }

  Future<void> loadInitial() async {
    try {
      _page = 1;
      final photos = await repo.search(query, _page);
      state = AsyncData(photos);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadMore() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    _page++;

    try {
      final current = state.value ?? [];
      final more = await repo.search(query, _page);
      state = AsyncData([...current, ...more]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }

    _isLoadingMore = false;
  }

  Future<void> refresh() async {
    try {
      _page = 1;
      final photos = await repo.search(query, _page);
      state = AsyncData(photos);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

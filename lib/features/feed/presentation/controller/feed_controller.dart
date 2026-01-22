import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/datasource/pexels_remote_datasource.dart';
import '../../data/models/pexels_photo.dart';
import '../../data/repository/feed_repository_impl.dart';

final feedControllerProvider =
StateNotifierProvider<FeedController, AsyncValue<List<PexelsPhoto>>>(
        (ref) {
      final dio = Dio();
      final remote = PexelsRemoteDataSource(dio);
      final repo = FeedRepositoryImpl(remote);
      return FeedController(repo);
    });

class FeedController extends StateNotifier<AsyncValue<List<PexelsPhoto>>> {
  final FeedRepositoryImpl repo;
  int _page = 1;
  bool _isLoadingMore = false;

  FeedController(this.repo) : super(const AsyncLoading()) {
    loadInitial();
  }

  Future<void> loadInitial() async {
    try {
      final photos = await repo.getFeed(_page);
      state = AsyncData(photos);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadMore() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    _page++;

    final current = state.value ?? [];
    final more = await repo.getFeed(_page);

    state = AsyncData([...current, ...more]);
    _isLoadingMore = false;
  }
}
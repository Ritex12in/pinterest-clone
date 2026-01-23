import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../feed/data/datasource/pexels_remote_datasource.dart';
import '../../../feed/data/models/pexels_photo.dart';
import '../../../feed/data/repository/feed_repository_impl.dart';

class SearchHomeState {
  final List<PexelsPhoto> featured;
  final Map<String, List<String>> sections;

  SearchHomeState({
    required this.featured,
    required this.sections,
  });
}

final searchHomeControllerProvider =
StateNotifierProvider<SearchHomeController, AsyncValue<SearchHomeState>>(
      (ref) {
    final dio = Dio();
    final remote = PexelsRemoteDataSource(dio);
    final repo = FeedRepositoryImpl(remote);
    return SearchHomeController(repo);
  },
);

class SearchHomeController extends StateNotifier<AsyncValue<SearchHomeState>> {
  final FeedRepositoryImpl repo;

  SearchHomeController(this.repo) : super(const AsyncLoading()) {
    load();
  }

  Future<void> load() async {
    try {
      final featured = await repo.search("aesthetic", 1);
      final education = await repo.search("education", 1);
      final drawing = await repo.search("drawings", 1);
      final travel = await repo.search("travel", 1);
      final nature = await repo.search("nature", 1);
      final animals = await repo.search("animals", 1);

      state = AsyncData(
        SearchHomeState(
          featured: featured.take(5).toList(),
          sections: {
            "Education": education.take(4).map((e) => e.imageUrl).toList(),
            "Drawings": drawing.take(4).map((e) => e.imageUrl).toList(),
            "Travel": travel.take(4).map((e) => e.imageUrl).toList(),
            "Nature": nature.take(4).map((e) => e.imageUrl).toList(),
            "Animals": animals.take(4).map((e) => e.imageUrl).toList(),
          },
        ),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

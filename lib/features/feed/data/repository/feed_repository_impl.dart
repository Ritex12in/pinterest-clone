import '../../domain/repository/feed_repository.dart';
import '../datasource/pexels_remote_datasource.dart';
import '../models/pexels_photo.dart';

class FeedRepositoryImpl implements FeedRepository {
  final PexelsRemoteDataSource remote;

  FeedRepositoryImpl(this.remote);

  @override
  Future<List<PexelsPhoto>> getFeed(int page) {
    return remote.getCuratedPhotos(page);
  }

  @override
  Future<List<PexelsPhoto>> search(String query, int page) {
    return remote.searchPhotos(query: query, page: page);
  }

}
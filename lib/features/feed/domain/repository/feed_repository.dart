import '../../data/models/pexels_photo.dart';

abstract class FeedRepository {
  Future<List<PexelsPhoto>> getFeed(int page);
  Future<List<PexelsPhoto>> search(String query, int page);
}
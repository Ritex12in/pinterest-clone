import '../../../feed/data/models/pexels_photo.dart';

class SearchHomeState {
  final List<PexelsPhoto> featured;
  final Map<String, List<String>> sections;

  SearchHomeState({
    required this.featured,
    required this.sections,
  });
}

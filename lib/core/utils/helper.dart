import '../../features/feed/data/models/pexels_photo.dart';

String buildRelatedQuery(PexelsPhoto photo) {
  final alt = photo.alt.toLowerCase();
  final stopWords = {
    "with",
    "and",
    "the",
    "during",
    "on",
    "in",
    "at",
    "a",
    "an",
    "of",
    "to",
  };

  final words = alt
      .replaceAll(RegExp(r'[^a-zA-Z ]'), '')
      .split(' ')
      .where((w) => w.length > 2 && !stopWords.contains(w))
      .toList();

  if (words.isEmpty) return "aesthetic";

  return words.first;
}

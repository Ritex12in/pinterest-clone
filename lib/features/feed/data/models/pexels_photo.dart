class PexelsPhoto {
  final int id;
  final int width;
  final int height;
  final String imageUrl;
  final String alt;
  final String avgColor;

  PexelsPhoto({
    required this.id,
    required this.width,
    required this.height,
    required this.imageUrl,
    required this.alt,
    required this.avgColor,
  });

  factory PexelsPhoto.fromJson(Map<String, dynamic> json) {
    return PexelsPhoto(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      imageUrl: json['src']['medium'],
      alt: json['alt'] ?? '',
      avgColor: json['avg_color'] ?? '#CCCCCC',
    );
  }
}

class PexelsPhoto {
  final int id;
  final int width;
  final int height;
  final String imageUrl;

  PexelsPhoto({
    required this.id,
    required this.width,
    required this.height,
    required this.imageUrl,
  });

  factory PexelsPhoto.fromJson(Map<String, dynamic> json) {
    return PexelsPhoto(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      imageUrl: json['src']['medium'],
    );
  }
}

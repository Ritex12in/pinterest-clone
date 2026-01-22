import 'package:dio/dio.dart';
import '../../../../core/constants/api_keys.dart';
import '../models/pexels_photo.dart';

class PexelsRemoteDataSource {
  final Dio dio;

  PexelsRemoteDataSource(this.dio);

  Future<List<PexelsPhoto>> getCuratedPhotos(int page) async {
    final response = await dio.get(
      "https://api.pexels.com/v1/curated",
      queryParameters: {
        "page": page,
        "per_page": 20,
      },
      options: Options(
        headers: {
          "Authorization": PEXELS_API_KEY,
        },
      ),
    );

    final List photos = response.data['photos'];
    return photos.map((e) => PexelsPhoto.fromJson(e)).toList();
  }
}

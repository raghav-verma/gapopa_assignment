import 'dart:convert';
import 'package:gapopa/core/constants/app_constants.dart';
import 'package:gapopa/features/image_gallery/models/index.dart';
import 'package:http/http.dart' as http;





/// A client for interacting with the Pixabay API.
class PixabayClient {
  final String apiKey = AppConstants.apiKey;

  /// Fetches images from the Pixabay API based on a query.
  Future<List<ImageModel>> fetchImages(String query, int page) async {
    final response = await http.get(
      Uri.parse('${AppConstants.baseUrl}?key=$apiKey&q=$query&image_type=photo&page=$page'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['hits'] as List).map((item) => ImageModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load images. Status code: ${response.statusCode}');
    }
  }
}

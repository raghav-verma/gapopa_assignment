// class ImageData {
//   final String id;
//   final String url;
//   int likes;
//   final int views;
//   bool isLiked = false;
//
//
//   ImageData({required this.id, required this.url, required this.likes, required this.views});
//
//   factory ImageData.fromJson(Map<String, dynamic> json) {
//     return ImageData(
//       id: json['id'].toString(),
//       url: json['webformatURL'],
//       likes: json['likes'],
//       views: json['views'],
//
//     );
//   }
// }


import 'package:get/get.dart';

// class ImageData {
//   final String id;
//   final String url;
//   final Strng
//   final int views;
//   RxBool isLiked;
//
//   ImageData({
//     required this.id,
//     required this.url,
//     required int likes,
//     required this.views,
//     bool isLiked = false,
//   })  : this.likes = likes.obs,
//         this.isLiked = isLiked.obs;
//
//   factory ImageData.fromJson(Map<String, dynamic> json) {
//     return ImageData(
//       id: json['id'].toString(),
//       url: json['webformatURL'],
//       likes: json['likes'],
//       views: json['views'],
//     );
//   }
// }

import 'package:get/get.dart';

class ImageData {
  final String id;
  final String url;
  RxInt likes;
  RxInt views;
  RxBool isLiked;

  ImageData({
    required this.id,
    required this.url,
    required this.likes,
    required this.views,
    required this.isLiked,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'].toString(),
      url: json['webformatURL'],
      likes: RxInt(json['likes'] ?? 0),  // Make sure to provide a default value
      views: RxInt(json['views'] ?? 0),  // in case the key doesn't exist in JSON
      isLiked: RxBool(false),  // Default to false or based on another JSON field if available
    );
  }
}


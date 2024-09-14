import 'package:get/get.dart';

class ImageModel {
  final String id;
  final String url;
  final String type;
  final String tags;
  final int downloads;
  final int collection;
  final int comments;
  final String user;
  RxInt likes;
  RxInt views;
  RxBool isLiked;

  ImageModel({
    required this.id,
    required this.url,
    required this.likes,
    required this.views,
    required this.isLiked,
    required this.collection,
    required this.comments,
    required this.downloads,
    required this.type,
    required this.tags,
    required this.user,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'].toString(),
      url: json['webformatURL'],
      likes: RxInt(json['likes'] ?? 0),
      views: RxInt(json['views'] ?? 0),
      isLiked: RxBool(json['isLiked'] ?? false),
      collection: json['collection'] ?? 0,
      comments: json['comments'] ?? 0,
      downloads: json['downloads'] ?? 0,
      type: json['type'] ?? '',
      tags: json['tags'] ?? '',
      user: json['user'] ?? '',
    );
  }
}

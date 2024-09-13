import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gapopa/core/extensions/index.dart';
import 'package:gapopa/features/image_gallery/controllers/index.dart';
import 'package:gapopa/features/image_gallery/models/index.dart';
import 'package:gapopa/features/image_gallery/views/widgets/index.dart';
import 'package:get/get.dart';

class ImageDetailsScreen extends GetView<ImageController> {
  final ImageModel image;

  const ImageDetailsScreen({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: Get.back,
        child: Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageValueTileWidget(
                          title: 'Likes',
                          value: image.likes.value.formatCount,
                        ),
                        ImageValueTileWidget(
                          title: 'Views',
                          value: image.views.value.formatCount,
                        ),
                        ImageValueTileWidget(
                          title: 'Comments',
                          value: image.comments.toString(),
                        ),
                        ImageValueTileWidget(
                          title: 'Downloads',
                          value: image.downloads.toString(),
                        ),
                        ImageValueTileWidget(
                          title: 'Type',
                          value: image.type,
                        ),
                        ImageValueTileWidget(
                          title: 'Tags',
                          value: image.tags,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: image.url,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





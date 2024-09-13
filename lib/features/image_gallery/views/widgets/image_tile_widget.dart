import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gapopa/core/extensions/index.dart';
import 'package:gapopa/features/image_gallery/controllers/index.dart';
import 'package:gapopa/features/image_gallery/models/index.dart';
import 'package:gapopa/features/image_gallery/views/screens/index.dart';
import 'package:gapopa/features/image_gallery/views/widgets/index.dart';
import 'package:get/get.dart';

class ImageTile extends GetView<ImageController> {
  final ImageModel image;

  const ImageTile({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0.8,
      child: LayoutBuilder(
        builder: (context, constraints) {

          int columns = constraints.maxWidth > 1200
              ? 4
              : constraints.maxWidth > 800
              ? 3
              : 2;
          double imageWidth = constraints.maxWidth;
          double imageHeight = imageWidth * 0.75;

          return GestureDetector(
            onTap: () => Get.to(() => ImageDetailsScreen(image: image)),
            child: Column(
              children: [
                SizedBox(
                  height: imageHeight,
                  width: imageWidth,
                  child: Hero(
                    tag: image.id,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: image.url,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (
                            final context,
                            final widget,
                            final event,
                            ) {
                          return CustomShimmerWidget(
                            height: imageHeight,
                            width: imageWidth,
                            radius: 0,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.withOpacity(0.6),
                        Colors.grey.withOpacity(0.2),
                        Colors.grey.withOpacity(0.2),
                        Colors.grey.withOpacity(0.6)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 2,
                  ),
                  child: Obx(
                        () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.toggleLike(image.id);
                              },
                              child: Icon(
                                controller.getImageById(image.id)?.isLiked.value ?? false
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: controller.getImageById(image.id)?.isLiked.value ?? false
                                    ? Colors.red
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(width: 8),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Text(image.likes.value.formatCount),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.remove_red_eye,
                            ),
                            const SizedBox(width: 2),
                            Text(image.views.value.formatCount),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



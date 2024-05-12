import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gapopa/features/image_gallery/controllers/index.dart';
import 'package:get/get.dart';
import '../../models/image_model.dart';
import 'image_tile_widget.dart';

class ImageGridViewWidget extends StatelessWidget {
  final List<ImageModel> images;
  final ScrollController controller;

  const ImageGridViewWidget({
    super.key,
    required this.images,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = constraints.maxWidth > 1200
            ? 4
            : constraints.maxWidth > 800
                ? 3
                : 2;
        return MasonryGridView.count(
          controller: controller,
          crossAxisCount: columns,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return ImageTile(image: images[index]);
          },
        );
      },
    );
  }
}

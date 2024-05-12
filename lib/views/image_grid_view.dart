import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../models/image_data.dart';
import 'image_tile.dart';

class ImageGridView extends StatelessWidget {
  final List<ImageData> images;
  final ScrollController controller;

  ImageGridView({required this.images, required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = constraints.maxWidth > 1200 ? 4 : constraints.maxWidth > 800 ? 3 : 2;
        return MasonryGridView.count(
          controller: controller,
          crossAxisCount: columns,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return ImageTile(image: images[index]);
          },
        );

      },
    );
  }
}

import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final double radius;

  const CustomShimmerWidget({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
  });

  @override
  Widget build(final BuildContext context) {
    return FadeShimmer(
      height: height,
      width: width,
      radius: radius,
      fadeTheme: Get.isDarkMode ? FadeTheme.dark : FadeTheme.light,
    );
  }
}

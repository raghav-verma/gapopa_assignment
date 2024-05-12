import 'package:get/get.dart';
import '../models/image_model.dart';

class ImageController extends GetxController {
  var _images = <ImageModel>[].obs;

  // Getter for images list
  List<ImageModel> get images => _images.toList();

  // Setter for images list
  set images(List<ImageModel> value) => _images.assignAll(value);

  void toggleLike(String id) {
    var image = images.firstWhereOrNull((img) => img.id == id);
    if (image != null) {
      print(
          "Toggling like for image ${image.id}: Currently liked? ${image.isLiked.value}");
      image.isLiked.value = !image.isLiked.value;
      image.likes.value += image.isLiked.value ? 1 : -1;
      print(
          "New like status: ${image.isLiked.value}, Total likes: ${image.likes.value}");
    } else {
      print("Image with ID $id not found");
    }
  }

  ImageModel? getImageById(String id) {
    return images.firstWhereOrNull((img) => img.id == id);
  }
}

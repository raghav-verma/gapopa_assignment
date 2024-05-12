import 'package:get/get.dart';
import '../models/image_data.dart';

class ImageController extends GetxController {

  var _images = <ImageData>[].obs;

  // Getter for images list
  List<ImageData> get images => _images.toList();

  // Setter for images list
  set images(List<ImageData> value) => _images.assignAll(value);



  void toggleLike(String id) {
    var image = images.firstWhereOrNull((img) => img.id == id);
    if (image != null) {
      print("Toggling like for image ${image.id}: Currently liked? ${image.isLiked.value}");
      image.isLiked.value = !image.isLiked.value;
      image.likes.value += image.isLiked.value ? 1 : -1;
      print("New like status: ${image.isLiked.value}, Total likes: ${image.likes.value}");
    } else {
      print("Image with ID $id not found");
    }
  }


  ImageData getImageById(String id) {
    return images.firstWhereOrNull((img) => img.id == id) ?? ImageData(id: '', url: '', likes: 0.obs, views: 0.obs, isLiked:false.obs );
  }
}




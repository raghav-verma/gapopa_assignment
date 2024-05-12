

// class ImageTile extends StatelessWidget {
//   final ImageData image;
//
//   ImageTile({required this.image});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.of(context).push(MaterialPageRoute(
//         builder: (_) => FullScreenImagePage(image: image),
//       )),
//       child: GridTile(
//         child: Hero(
//           tag: image.id,
//           child: Image.network(image.url, fit: BoxFit.cover),
//         ),
//         footer: Container(
//           color: Colors.black54,
//           child: ListTile(
//             leading: Icon(Icons.thumb_up, color: Colors.white, size: 20),
//             title: Text("${image.likes} Likes", style: TextStyle(color: Colors.white)),
//             subtitle: Text("${image.views} Views", style: TextStyle(color: Colors.white)),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import '../models/image_data.dart';
// import 'full_screen_image_page.dart';
//
// class ImageTile extends StatefulWidget {
//   final ImageData image;
//
//   ImageTile({required this.image});
//
//   @override
//   State<ImageTile> createState() => _ImageTileState();
// }
//
// class _ImageTileState extends State<ImageTile> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.of(context).push(MaterialPageRoute(
//         builder: (_) => FullScreenImagePage(image: widget.image),
//       )),
//       child: Column(
//         children: [
//           Container(
//               width: MediaQuery.of(context).size.width / 4,
//               child: Hero(
//                   tag: widget.image.id,
//                   child: Image.network(widget.image.url, fit: BoxFit.cover))),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: (){
//                               setState(() {
//                                 widget.image.isLiked = !widget.image.isLiked;
//                                 if(widget.image.isLiked){
//                                   widget.image.likes +=1;
//                                 }else{
//                                   widget.image.likes-=1;
//                                 }
//                               });
//                       },
//                       icon: Icon(widget.image.isLiked? Icons.favorite : Icons.favorite_border_outlined,
//                       color: widget.image.isLiked? Colors.red : Colors.black,
//                       ),
//                       tooltip: 'Like',
//                     ),
//                     const SizedBox(
//                       width: 2,
//                     ),
//                     Text("${widget.image.likes} Likes"),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const Icon(Icons.remove_red_eye),
//                     const SizedBox(
//                       width: 2,
//                     ),
//                     Text("${widget.image.views} Views"),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/image_data.dart';
import '../controllers/image_controller.dart';
import 'full_screen_image_page.dart';

class ImageTile extends StatelessWidget {
  final ImageData image;

  ImageTile({required this.image});

  @override
  Widget build(BuildContext context) {
    final ImageController controller = Get.find();

    return GestureDetector(
      onTap: () => Get.to(() => FullScreenImagePage(image: image)),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Hero(
              tag: image.id,
              child: Image.network(image.url, fit: BoxFit.cover),
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    controller.toggleLike(image.id);
                  },
                  icon: Obx(()=>Icon(
                    controller.getImageById(image.id).isLiked.value ? Icons.favorite : Icons.favorite_border,
                    color: controller.getImageById(image.id).isLiked.value ? Colors.red : Colors.black,
                  )),
                  tooltip: 'Like',
                ),
    Obx(() =>Text("${image.likes.value} Likes")),
                Icon(Icons.remove_red_eye),
                Text("${image.views} Views"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


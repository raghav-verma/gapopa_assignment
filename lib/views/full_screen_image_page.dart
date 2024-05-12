// import 'package:flutter/material.dart';
// import '../models/image_data.dart';
//
// class FullScreenImagePage extends StatelessWidget {
//   final ImageData image;
//
//   FullScreenImagePage({super.key, required this.image});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Full Image'),
//       ),
//       body: GestureDetector(
//         onTap: () => Navigator.of(context).pop(),
//         child: Center(
//           child: Column(
//             children: [
//               Container(width: MediaQuery.of(context).size.width/4,child: Hero(tag: image.id, child: Image.network(image.url, fit: BoxFit.cover ))),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: (){
//
//                           },
//                           icon: Icon(image.isLiked? Icons.favorite : Icons.favorite_border_outlined,
//                             color: image.isLiked? Colors.red : Colors.black,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 2,
//                         ),
//                         Text("${image.likes} Likes"),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Icon(Icons.remove_red_eye),
//                         const SizedBox(
//                           width: 2,
//                         ),
//                         Text("${image.views} Views"),
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import '../models/image_data.dart';
//
// class FullScreenImagePage extends StatefulWidget {
//   final ImageData image;
//
//   FullScreenImagePage({super.key, required this.image});
//
//   @override
//   State<FullScreenImagePage> createState() => _FullScreenImagePageState();
// }
//
// class _FullScreenImagePageState extends State<FullScreenImagePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Full Image'),
//       ),
//       body: GestureDetector(
//         onTap: () => Navigator.of(context).pop(),
//         child: Center(
//           child: Column(
//             children: [
//               Expanded(
//                 child: Hero(
//                   tag: widget.image.id,
//                   child: Image.network(widget.image.url, fit: BoxFit.cover),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             setState(() {
//                               widget.image.isLiked = !widget.image.isLiked;
//                               if (widget.image.isLiked) {
//                                 widget.image.likes++;
//                               } else {
//                                 widget.image.likes--;
//                               }
//                             });
//                           },
//                           icon: Icon(
//                             widget.image.isLiked ? Icons.favorite : Icons.favorite_border_outlined,
//                             color: widget.image.isLiked ? Colors.red : Colors.black,
//                           ),
//                         ),
//                         Text("${widget.image.likes} Likes"),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Icon(Icons.remove_red_eye),
//                         SizedBox(width: 2),
//                         Text("${widget.image.views} Views"),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/image_controller.dart';
import '../models/image_data.dart';

class FullScreenImagePage extends StatelessWidget {
  final ImageData image;

  FullScreenImagePage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final ImageController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Full Image'),
      ),
      body: GestureDetector(
        onTap: Get.back,
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Hero(
                  tag: image.id,
                  child: Image.network(image.url, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => controller.toggleLike(image.id),
                      icon: Obx(()=>Icon(
                        controller.getImageById(image.id).isLiked.value ? Icons.favorite : Icons.favorite_border,
                        color: controller.getImageById(image.id).isLiked.value ? Colors.red : Colors.black,
                      )),
                    ),
      Obx(() =>Text("${controller.getImageById(image.id).likes} Likes")),
                    Icon(Icons.remove_red_eye),
                    Text("${image.views} Views"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

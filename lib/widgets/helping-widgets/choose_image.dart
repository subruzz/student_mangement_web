// import 'dart:typed_data';

// import 'package:flutter/material.dart';

// class ChooseImage extends StatelessWidget {
//   const ChooseImage({super.key, required this.image, required this.pickImage});
//   final Uint8List? image;
//   final void Function() pickImage;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         image != null
//             ? CircleAvatar(
//                 radius: 64,
//                 backgroundImage: MemoryImage(image!),
//               )
//             : const CircleAvatar(
//                 radius: 64,
//                 backgroundImage: NetworkImage(
//                     'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png')),
//         Positioned(
//             bottom: -10,
//             left: 80,
//             child: IconButton(
//                 onPressed: pickImage, icon: const Icon(Icons.add_a_photo)))
//       ],
//     );
//   }
// }

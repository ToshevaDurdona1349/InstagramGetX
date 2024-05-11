import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../controller/upload_controller.dart';
import '../model/post_model.dart';

void showPicker(BuildContext context,MyUploadController uploadController) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Pick Photo'),
                  onTap: () {
                    uploadController.imgFromGallery();
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take Photo'),
                onTap: () {
                  uploadController.imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      });
}
Widget itemOfPost(Post post,MyUploadController uploadController,BuildContext context) {
  return GestureDetector(
      onLongPress: () {
        uploadController.dialogRemovePost(post,context);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: post.img_post,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              post.caption,
              style: TextStyle(color: Colors.black87.withOpacity(0.7)),
              maxLines: 2,
            )
          ],
        ),
      ));
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../controller/profile_controller.dart';
import '../model/post_model.dart';

Widget itemOfPost(Post post,MyProfileController profileController,BuildContext context) {
  return GestureDetector(
      onLongPress: () {
        profileController.dialogRemovePost(post,context);
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
showPicker(MyProfileController profileController,BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Pick Photo'),
                  onTap: () {
                    profileController.imgFromGallery();
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take Photo'),
                onTap: () {
                  profileController.imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      });
}
import 'package:flutter/material.dart';

import '../controller/upload_controller.dart';

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
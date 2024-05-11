import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../model/post_model.dart';
import '../services/db_service.dart';
import '../services/file_service.dart';
import '../services/utils_service.dart';

class MyUploadController extends GetxController{
  bool isLoading = false;
  var captionController = TextEditingController();
  int count_posts = 0;
  int axisCount = 2;
  final ImagePicker picker = ImagePicker();
  File? image;
  List<Post> items = [];


  moveToFeed(PageController pageController) {
    isLoading = false;
    update();

    captionController.text = "";
    image = null;
    pageController.animateToPage(0, duration: const Duration(microseconds: 200), curve: Curves.easeIn);
  }

  imgFromGallery() async {
    XFile? img = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    image = File(img!.path);
    update();
  }

  imgFromCamera() async {
    XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    image = XFile(image!.path);
    update();
  }



  uploadNewPost(PageController pageController) {
    String caption = captionController.text.toString().trim();
    if (caption.isEmpty) return;
    if (image == null) return;
    apiPostImage(pageController);
  }

  void apiPostImage(PageController pageController){
    isLoading = true;
    update();

    FileService.uploadPostImage(image!).then((downloadUrl) => {
      resPostImage(downloadUrl,pageController),
    });
  }

  void resPostImage(String downloadUrl,PageController pageController){
    String caption = captionController.text.toString().trim();
    Post post = Post(caption, downloadUrl);
    apiStorePost(post,pageController);
  }

  void apiStorePost(Post post, PageController pageController,)async{
    // Post to posts
    Post posted = await DBService.storePost(post);
    // Post to feeds
    DBService.storeFeed(posted).then((value) => {
      moveToFeed(pageController),
    });
  }
  dialogRemovePost(Post post,BuildContext context) async {
    var result = await Utils.dialogCommon(context, "Instagram", "Do you want to detele this post?", false);
    if (result) {
      isLoading = true;
      update();

      DBService.removePost(post).then((value) => {
        apiLoadPosts(),
      });
    }
  }
  apiLoadPosts() {
    DBService.loadPosts().then((value) => {
      resLoadPosts(value),
    });
  }
  resLoadPosts(List<Post> posts) {
    isLoading = false;
    items = posts;
    count_posts = posts.length;
    update();
  }
}

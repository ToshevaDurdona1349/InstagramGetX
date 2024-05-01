import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import '../model/post_model.dart';
import '../services/db_service.dart';
import '../services/utils_service.dart';

class MyFeedController extends GetxController{
  bool isLoading = false;

  List<Post> items = [];

  void apiPostLike(Post post) async {
    isLoading = true;
    update();

    await DBService.likePost(post, true);
    isLoading = false;
    Visibility(
      visible: post.liked,
      child: Center(
        child: Lottie.asset(
          'assets/lottie/heart.json',
          width: 100,
          height: 100,
        ),
      ),
    );
    update();
  }

  void apiPostUnLike(Post post) async {
    isLoading = true;
    update();

    await DBService.likePost(post, false);
    isLoading = false;
    post.liked = false;
    update();
  }

  apiLoadFeeds() {
    isLoading = true;
    update();

    DBService.loadFeeds().then((value) => {
      resLoadFeeds(value),
    });
  }

  resLoadFeeds(List<Post> posts) {
    items = posts;
    isLoading = false;
    update();
  }

  dialogRemovePost(BuildContext context,Post post) async {
    var result = await Utils.dialogCommon(context, "Instagram", "Do you want to detele this post?", false);

    if (result) {
      isLoading = true;
      update();
      DBService.removePost(post).then((value) => {
        apiLoadFeeds(),
      });
    }
  }

  share(Post post) async {
    await Share.share(post.img_post);
  }

}
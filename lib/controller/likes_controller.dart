import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../model/post_model.dart';
import '../services/db_service.dart';
import '../services/utils_service.dart';

class MyLikesController extends GetxController{
  bool isLoading = false;
  List<Post> items = [];

  void apiLoadLikes() {
    isLoading = true;
    update();

    DBService.loadLikes().then((value) => {
      resLoadPost(value),
    });
  }

  void resLoadPost(List<Post> posts) {
    items = posts;
    isLoading = false;
    update();
  }

  void apiPostUnLike(Post post) async {
    isLoading = true;
    update();

    await DBService.likePost(post, false);
    apiLoadLikes();
  }
  dialogRemovePost(Post post,BuildContext context) async {
    var result = await Utils.dialogCommon(context, "Instagram", "Do you want to detele this post?", false);

    if (result) {
      isLoading = true;
      update();

      DBService.removePost(post).then((value) => {
        apiLoadLikes(),
      });
    }
  }

  share(Post post) async {
    await Share.share(post.img_post);
  }
}
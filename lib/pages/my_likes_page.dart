
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/likes_controller.dart';
import '../witgets/item_of_likes.dart';


class MyLikesPage extends StatefulWidget {
  const MyLikesPage({Key? key}) : super(key: key);

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  final likesController = Get.find<MyLikesController>();

  @override
  void initState() {
    super.initState();
    likesController.apiLoadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Likes",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
        ),
      ),
      body:GetBuilder<MyLikesController>(
        builder: (_){
          return Stack(
        children: [
          ListView.builder(
            itemCount: likesController.items.length,
            itemBuilder: (ctx, index) {
              return itemOfPost(likesController,likesController.items[index],context);
            },
          ),
          likesController.isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : const SizedBox.shrink(),
        ],
      );
        },
      ),
    );
  }



}
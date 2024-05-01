
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';
import '../views/item_of_profile.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final profileController = Get.find<MyProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.apiLoadMember();
    profileController.apiLoadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyProfileController>(
        builder: (_){
          return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Profile",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Billabong", fontSize: 25),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  profileController.dialogLogout(context);
                },
                icon: const Icon(Icons.exit_to_app),
                color: const Color.fromRGBO(193, 53, 132, 1),
              )
            ],
          ),
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    //#myphoto
                    GestureDetector(
                        onTap: () {
                          showPicker(profileController,context);
                        },
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                border: Border.all(
                                  width: 1.5,
                                  color: const Color.fromRGBO(193, 53, 132, 1),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: profileController.img_url.isEmpty
                                    ? const Image(
                                  image: AssetImage(
                                      "assets/images/ic_person.png"),
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )
                                    : Image.network(
                                  profileController.img_url,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 80,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.add_circle,
                                    color: Colors.purple,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),

                    //#myinfos
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      profileController.fullname.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      profileController.email,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),

                    //#mycounts
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 80,
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    profileController.count_posts.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "POSTS",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    profileController.count_followers.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "FOLLOWERS",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    profileController.count_following.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "FOLLOWING",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //list or grid
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  profileController.axisCount = 1;
                                });
                              },
                              icon: Icon(Icons.list_alt),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  profileController.axisCount = 2;
                                });
                              },
                              icon: const Icon(Icons.grid_view),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //#myposts
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: profileController.axisCount),
                        itemCount: profileController.items.length,
                        itemBuilder: (ctx, index) {
                          return itemOfPost(profileController.items[index],profileController,context);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              profileController.isLoading? const Center(
                child: CircularProgressIndicator(),
              ): const SizedBox.shrink(),
            ],
          ));});
    }
  }



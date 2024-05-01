
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/upload_controller.dart';
import '../views/item_of_upload.dart';

class MyUploadPage extends StatefulWidget {
  final PageController? pageController;

  const MyUploadPage({Key? key, this.pageController}) : super(key: key);

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  final uploadController = Get.find<MyUploadController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyUploadController>(
        builder: (_){
          return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Upload",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  uploadController.uploadNewPost(widget.pageController!);
                },
                icon: const Icon(
                  Icons.drive_folder_upload,
                  color: Color.fromRGBO(193, 53, 132, 1),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showPicker(context,uploadController);
                        },
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery
                              .of(context)
                              .size
                              .width,
                          color: Colors.grey.withOpacity(0.4),
                          child: uploadController.image == null
                              ? const Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.grey,
                            ),
                          )
                              : Stack(
                            children: [
                              Image.file(
                                uploadController.image!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: double.infinity,
                                color: Colors.black12,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          uploadController.image = null;
                                        });
                                      },
                                      icon: const Icon(Icons.highlight_remove),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: TextField(
                          controller: uploadController.captionController,
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          decoration: const InputDecoration(
                              hintText: "Caption",
                              hintStyle:
                              TextStyle(fontSize: 17, color: Colors.black38)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              uploadController.isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : const SizedBox.shrink(),
            ],
          ),
          );
        },
    );
    }
  }

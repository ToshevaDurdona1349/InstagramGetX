import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/search_controller.dart';
import '../witgets/item_of_search.dart';


class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key}) : super(key: key);

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  final mysearchController = Get.find<MySearchController>();

  @override
  void initState() {
    super.initState();
    mysearchController.apiSearchMembers("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Search",
            style: TextStyle(
                color: Colors.black, fontFamily: "Billabong", fontSize: 25),
          ),
        ),
        body:GetBuilder<MySearchController>(
        builder: (_){
          return Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  //#search member
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(7)),
                    child: TextField(
                      style: const TextStyle(color: Colors.black87),
                      controller: mysearchController.searchController,
                      decoration: const InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.grey),
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          )),
                    ),
                  ),

                  //#member list
                  Expanded(
                    child: ListView.builder(
                      itemCount: mysearchController.items.length,
                      itemBuilder: (ctx, index) {
                        return itemOfMember(mysearchController,mysearchController.items[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        },
    ),
    );
  }


}

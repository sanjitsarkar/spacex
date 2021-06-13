import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:spacex/domain/entity/ship.dart';
import 'package:spacex/presentation/controllers/spacex_controller.dart';
import 'package:spacex/shared/constants.dart';

class SpaceXHomeView extends GetWidget<SpaceXController> {
  @override
  Widget build(BuildContext context) {
    controller.scrollController.value.addListener(() async {
      if (controller.scrollController.value.position.pixels ==
          controller.scrollController.value.position.maxScrollExtent) {
        if (controller.size.value != 0) {
          controller.offset.value += controller.size.value;
          await controller.searchShips();
        } else
          controller.offset.value = controller.ships.length;
        // print("reached");
      }
    });
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: TextField(
              controller: controller.searchName.value,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  suffixIcon: IconButton(
                      onPressed: () => {},
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      )),
                  fillColor: Colors.black12.withOpacity(.1),
                  hintText: "Search By Name..",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(.5))),
              onSubmitted: (value) async {
                if (value != controller.search["name"] && value.isNotEmpty) {
                  controller.ships.clear();
                  controller.offset.value = 0;
                  controller.search.value = {"name": value};
                  controller.isLoading.value = true;
                  await controller.searchShips();
                  controller.isLoading.value = false;
                } else {
                  Get.showSnackbar(GetBar(
                    barBlur: 20,
                    title: "Notice",
                    message: "Search something...",
                    duration: Duration(seconds: 2),
                    animationDuration: Duration(milliseconds: 500),
                    backgroundColor: Colors.blueGrey,
                    leftBarIndicatorColor: Colors.yellow,
                    boxShadows: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.3), blurRadius: 5)
                    ],
                    dismissDirection: SnackDismissDirection.HORIZONTAL,
                    overlayBlur: 10,
                    snackPosition: SnackPosition.TOP,
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.yellow,
                    ),
                  ));
                }
              },
            )),
        drawer: Drawer(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blueAccent,
              ),
            );
          } else if (controller.ships.isEmpty) {
            return Center(
              child: Text(
                controller.label.value,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            );
          }
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ships",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    filterButton()
                  ],
                ),
              ),
              customCard(context: context),
            ],
          );
        }));
  }

  Expanded customCard({required BuildContext context}) {
    return Expanded(
      child: GridView.builder(
        controller: controller.scrollController.value,
        itemCount: controller.ships.length,
        // shrinkWrap: true,

        // primary: true,
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: o(context) == Orientation.portrait ? 1 : 2,
            crossAxisSpacing: 20),
        itemBuilder: (BuildContext context, int i) {
          final Ship ship = controller.ships[i];
          return Container(
            height: o(context) == Orientation.portrait
                ? h(context) * .3
                : h(context) * .5,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(.3), blurRadius: 5)
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Material(
              child: InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CachedNetworkImage(
                        cacheKey: ship.name,
                        imageUrl: ship.image,
                        fit: BoxFit.cover,
                        width: w(context),
                        placeholder: (context, url) {
                          return SpinKitFadingCircle(
                            color: Colors.blueAccent,
                          );
                        },
                        placeholderFadeInDuration: Duration(milliseconds: 200),
                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                                fit: FlexFit.tight,
                                child: Text(ship.name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.subtitle1)),
                            // Spacer(),
                            Row(
                              children: [
                                Icon(Icons.date_range),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  ship.yearBuilt.toString(),
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  IconButton filterButton() {
    return IconButton(
        constraints: BoxConstraints(),
        padding: EdgeInsets.zero,
        onPressed: () {
          // Get.bottomSheet(BottomSheet(
          //   builder: (context) {
          //     return Obx(() => bottomSheetBody(context));
          //   },
          //   onClosing: () {},
          // ));
        },
        icon: Icon(Icons.filter_alt_sharp));
  }

  SingleChildScrollView bottomSheetBody(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          child: Container(
        padding: EdgeInsets.all(30),
        height: h(context) * .7,
        width: w(context),
        child: Column(
          children: [
            Text(
              "Filter",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Slider(
              min: 5,
              max: 100,
              divisions: 19,
              label: "Limit",
              value: controller.limit.value,
              onChanged: (double value) async {
                controller.limit.value = value;
              },
            ),
            Text(controller.limit.value.toString()),
            Divider(),
            TextField(
              controller: controller.searchName.value,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.black12.withOpacity(.1),
                  hintText: "Search By Name.."),
              onSubmitted: (value) async {
                // double limit = controller.limit.value;
                // int length = controller.ships.length;

                // int offset = controller.offset.value;
                // // await controller.searchShips();
                // // print(controller.search.toString());
                // controller.offset.value = 0;
                // if (limit < length &&
                //     value == controller.search["name"]) {
                //   controller.ships
                //       .removeRange(limit.toInt(), length);
                // } else if (limit < length) {
                //   controller.search.value = {"name": value};

                //   controller.ships.clear();
                //   await controller.searchShips();
                // } else if (limit == length &&
                //     value == controller.search["name"]) {
                //   // controller.limit.value = value;
                // } else if (limit == length) {
                //   controller.search.value = {"name": value};

                //   controller.ships.clear();
                //   await controller.searchShips();
                // } else if (value == controller.search["name"]) {
                //   controller.offset.value = length;
                //   // controller.ships.clear();

                //   await controller.searchShips();
                // } else {
                //   // controller.offset.value = length;
                //   controller.ships.clear();
                //   controller.search.value = {"name": value};
                // }
                await controller.searchShips();
                Get.back();
                // print(limit);
                // print(length);
                // print(offset);
                // print(value);
              },
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  double limit = controller.limit.value;
                  int length = controller.ships.length;

                  int offset = controller.offset.value;
                  // await controller.searchShips();
                  // print(controller.search.toString());
                  // controller.offset.value = 0;
                  // if (limit < length &&
                  //     controller.searchName.value.text ==
                  //         controller.search["name"]) {
                  //   controller.ships
                  //       .removeRange(limit.toInt(), length);
                  // } else if (limit < length) {
                  //   controller.search.value = {
                  //     "name": controller.searchName.value.text
                  //   };

                  //   controller.ships.clear();
                  //   await controller.searchShips();
                  // } else if (limit == length &&
                  //     controller.searchName.value.text ==
                  //         controller.search["name"]) {
                  //   // controller.limit.value = value;
                  // } else if (limit == length) {
                  //   controller.search.value = {
                  //     "name": controller.searchName.value.text
                  //   };

                  //   controller.ships.clear();
                  //   await controller.searchShips();
                  // } else if (controller.searchName.value.text ==
                  //     controller.search["name"]) {
                  //   controller.offset.value = length;
                  //   // controller.ships.clear();

                  //   await controller.searchShips();
                  // } else {
                  //   // controller.offset.value = length;
                  //   controller.ships.clear();
                  //   controller.search.value = {
                  //     "name": controller.searchName.value.text
                  //   };
                  //   await controller.searchShips();
                  // }
                  await controller.searchShips();

                  Get.back();
                },
                icon: Icon(Icons.search),
                label: Text("Search"))
          ],
        ),
      )),
    );
  }
}

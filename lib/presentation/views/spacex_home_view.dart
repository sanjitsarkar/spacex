import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:spacex/domain/entity/ship.dart';
// import 'package:spacex/domain/entity/ships.dart';
import 'package:spacex/presentation/controllers/spacex_controller.dart';
import 'package:spacex/shared/constants.dart';

class SpaceXHomeView extends GetWidget<SpaceXController> {
  @override
  Widget build(BuildContext context) {
    // controller.scrollController.value.addListener(() async {
    //   if (controller.scrollController.value.position.pixels ==
    //       controller.scrollController.value.position.maxScrollExtent) {
    //     controller.offset.value += 5;
    //     await controller.searchShips();
    //   }
    // });
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("SpaceX"),
        ),
        drawer: Drawer(),
        body: Obx(() => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
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
                customCard(),
              ],
            )));
  }

  Expanded customCard() {
    return Expanded(
      child: ListView.builder(
        controller: controller.scrollController.value,
        itemCount: controller.ships.length,
        padding: EdgeInsets.all(20),
        itemBuilder: (BuildContext context, int i) {
          final Ship ship = controller.ships[i];
          return Container(
            height: h(context) * .3,
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
          Get.bottomSheet(BottomSheet(
            builder: (context) {
              return Obx(() => Form(
                      child: Container(
                    height: h(context) * .7,
                    width: w(context),
                    child: Column(
                      children: [
                        Text(
                          "Filter",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Slider(
                          min: 5,
                          max: 100,
                          divisions: 5,
                          label: "Limit",
                          value: controller.limit.value,
                          onChanged: (double value) async {
                            controller.limit.value = value;
                            double limit = controller.limit.value;
                            int length = controller.ships.length;

                            int offset = controller.offset.value;

                            if (limit < length) {
                              controller.ships
                                  .removeRange(limit.toInt(), length);
                            } else if (limit == length) {
                              // controller.limit.value = value;
                            } else {
                              controller.offset.value = length;
                              // controller.limit.value = value;
                              await controller.searchShips();
                            }
                            print(limit);
                            print(length);
                            print(offset);
                          },
                        ),
                        Text(controller.limit.value.toString()),
                        Divider(),
                      ],
                    ),
                  )));
            },
            onClosing: () {},
          ));
        },
        icon: Icon(Icons.filter_alt_sharp));
  }
}

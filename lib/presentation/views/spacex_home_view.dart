import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:spacex/domain/entity/ship.dart';
import 'package:spacex/presentation/controllers/spacex_controller.dart';
import 'package:spacex/shared/constants.dart';

class SpaceXHomeView extends GetView<SpaceXController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: controller.obx(
          (state) {
            return ListView.builder(
              itemCount: state!.ships.length,
              padding: EdgeInsets.all(20),
              itemBuilder: (BuildContext context, int i) {
                final Ship ship = state.ships[i];
                return Container(
                  height: h(context) * .3,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3), blurRadius: 5)
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
                              placeholderFadeInDuration:
                                  Duration(milliseconds: 200),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1)),
                                  // Spacer(),
                                  Row(
                                    children: [
                                      Icon(Icons.date_range),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        ship.yearBuilt.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
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
            );
          },
        ));
  }
}

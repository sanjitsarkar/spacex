import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spacex/domain/adapters/spacex_adapter.dart';
import 'package:spacex/domain/entity/data.dart';
import 'package:spacex/domain/entity/ship.dart';

class SpaceXController extends GetxController {
  final ISpaceXRepository repository;
  SpaceXController({required this.repository});
  RxDouble limit = RxDouble(5);
  RxBool isLoading = RxBool(false);
  Rx<TextEditingController> searchName =
      Rx<TextEditingController>(TextEditingController(text: ""));
  RxList<Ship> ships = RxList<Ship>.empty();
  RxMap<String, dynamic> search = RxMap({"name": ""});
  RxInt offset = RxInt(0);
  RxInt size = RxInt(0);
  // RxBool isMoreAvaialble = RxBool(true);
  RxString label = RxString("Search Something");
  Rx<ScrollController> scrollController = ScrollController().obs;
  @override
  void onInit() {
    super.onInit();

    // searchShips();
  }

  Future searchShips() async {
    // data.value = Data(ships: []);
    // isLoading.value = true;
    searchName.value.text = search["name"];
    // print("called");
    print(ships.length);
    Data _data = await repository.searchShip(
        limit: limit.value.toInt(), offset: offset.value, search: search);
    // print(_data.toString());
    // isLoading.value = false;
    size.value = _data.ships.length;
    // if (_data.ships.isEmpty) isMoreAvaialble.value = false;
    ships.addAll(_data.ships);
    if (ships.isEmpty) label.value = "No result found...";

    // append((val) => repository.searchShip(limit: 12));
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}

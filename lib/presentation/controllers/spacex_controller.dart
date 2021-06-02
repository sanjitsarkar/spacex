import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spacex/domain/adapters/spacex_adapter.dart';
import 'package:spacex/domain/entity/data.dart';
import 'package:spacex/domain/entity/ship.dart';

class SpaceXController extends GetxController {
  final ISpaceXRepository repository;
  SpaceXController({required this.repository});
  RxDouble limit = RxDouble(10);
  RxString name = RxString("");
  RxList<Ship> ships = RxList<Ship>.empty();
  RxInt offset = RxInt(0);
  Rx<ScrollController> scrollController = ScrollController().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    searchShips();
  }

  Future searchShips() async {
    // data.value = Data(ships: []);
    print("called");
    Data _data = await repository.searchShip(
        limit: limit.value.toInt(), offset: offset.value);
    // print(_data.toString());
    ships.addAll(_data.ships);

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

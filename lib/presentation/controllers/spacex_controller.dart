import 'package:get/get.dart';
import 'package:spacex/domain/adapters/spacex_adapter.dart';
import 'package:spacex/domain/entity/data.dart';

class SpaceXController extends SuperController<Data> {
  final ISpaceXRepository repository;
  SpaceXController({required this.repository});
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    append(() => repository.searchShip);
    searchShips();
  }

  Future searchShips() async {
    repository.searchShip();
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

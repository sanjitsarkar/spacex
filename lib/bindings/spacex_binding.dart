import 'package:get/get.dart';
import 'package:spacex/data/spacex_provider.dart';
import 'package:spacex/data/spacex_repository.dart';
import 'package:spacex/domain/adapters/spacex_adapter.dart';
import 'package:spacex/presentation/controllers/spacex_controller.dart';

class SpaceXBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetConnect>(() => GetConnect());
    Get.lazyPut<ISpaceXProvider>(() => SpaceXProvider(connect:Get.find()));
    Get.lazyPut<ISpaceXRepository>(
        () => SpaceXRepository(provider: Get.find()));
    Get.lazyPut<SpaceXController>(
        () => SpaceXController(repository: Get.find()));
  }
}

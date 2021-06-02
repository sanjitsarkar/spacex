import 'package:get/get.dart';
import 'package:spacex/bindings/spacex_binding.dart';
import 'package:spacex/presentation/views/spacex_home_view.dart';
import 'package:spacex/routes/app_routes.dart';

class AppPages {
  static const INITIAL_ROUTE = Routes.SPACEX_HOME;
  static final pages = [
    GetPage(name: Routes.SPACEX_HOME, page: () => SpaceXHomeView(),binding: SpaceXBinding())
  ];
}

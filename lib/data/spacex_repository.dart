import 'package:spacex/domain/adapters/spacex_adapter.dart';
import 'package:spacex/domain/entity/data.dart';

import 'spacex_provider.dart';

class SpaceXRepository implements ISpaceXRepository {
  SpaceXRepository({required this.provider});
  final ISpaceXProvider provider;
  @override
  Future<Data> searchShip(
      {int? limit, int? offset, Map<String, dynamic>? search}) async {
    final data = await provider.searchShip();
    // print(data.body);
    return data.body!;
  }
}

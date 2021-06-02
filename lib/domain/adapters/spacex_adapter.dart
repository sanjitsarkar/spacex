import 'package:spacex/domain/entity/data.dart';

abstract class ISpaceXRepository {
  Future<Data> searchShip(
      {int? limit, int? offset, Map<String, dynamic>? search});
}

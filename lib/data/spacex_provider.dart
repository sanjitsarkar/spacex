import 'package:get/get.dart';
import 'package:spacex/domain/entity/data.dart';

abstract class ISpaceXProvider {
  Future<GraphQLResponse<Data>> searchShip(
      {int? limit, int? offset, Map<String, dynamic>? search});
}

class SpaceXProvider extends GetConnect implements ISpaceXProvider {
  final GetConnect connect;

  SpaceXProvider({required this.connect});
  @override
  void onInit() {
    super.onInit();
    connect.baseUrl = 'https://api.spacex.land/graphql/';
    connect.defaultDecoder = (val) {
      print(val);
      return Data.fromMap(val);
    };
  }

  @override
  Future<GraphQLResponse<Data>> searchShip(
      {int? limit = 5, int? offset, Map<String, dynamic>? search}) async {
    print(limit);
    final response = await connect.query(
      """
      {
  ships(limit:$limit,offset:$offset) {
    image
    active
    home_port
    id
    missions {
      flight
      name
    }
    name
    year_built
  }
}

      """,
    );

    // return response;
    // print(response);
    return GraphQLResponse<Data>(
        body: Data.fromMap(response.body),
        graphQLErrors: response.graphQLErrors);
    // final connect = GetConnect();

//     connect.baseUrl = "https://api.spacex.land/graphql/";

//     GraphQLResponse<Data> response = await connect.query(
//       r"""
//       {
//   ships(limit: 10) {
//     image
//     active
//     home_port
//     id
//     missions {
//       flight
//       name
//     }
//     name
//     year_built
//   }
// }

//       """,
//     );
//     print("response" + response.body.toString());
    // return GraphQLResponse<Data>(body: Data(ships: []));
  }
//       query(r"""
//       {
//   ships(limit: 10) {
//     image
//     active
//     home_port
//     id
//     missions {
//       flight
//       name
//     }
//     name
//     year_built
//   }
// }

//       """);
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:spacex/domain/entity/ship.dart';

class Data {
  final List<Ship> ships;
  Data({
    required this.ships,
  });

  Data copyWith({
    List<Ship>? ships,
  }) {
    return Data(
      ships: ships ?? this.ships,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ships': ships.map((x) => x.toMap()).toList(),
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      ships: List<Ship>.from(map['ships']?.map((x) => Ship.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() => 'Data(ships: $ships)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Data &&
      listEquals(other.ships, ships);
  }

  @override
  int get hashCode => ships.hashCode;
}
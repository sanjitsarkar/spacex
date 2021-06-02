import 'dart:convert';

import 'data.dart';

class Ship {
  final Data data;
  Ship({
    required this.data,
  });

  Ship copyWith({
    Data? data,
  }) {
    return Ship(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
    };
  }

  factory Ship.fromMap(Map<String, dynamic> map) {
    return Ship(
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ship.fromJson(String source) => Ship.fromMap(json.decode(source));

  @override
  String toString() => 'Ship(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Ship &&
      other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}
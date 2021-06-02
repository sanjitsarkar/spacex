import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'mission.dart';

class Ship {
  final String image;
  final bool? active;
  final String? homePort;
  final String? id;
  final List<Mission>? missions;
  final String? name;
  final String? yearBuilt;
  Ship({
    required this.image,
    required this.active,
    required this.homePort,
    required this.id,
    required this.missions,
    required this.name,
    required this.yearBuilt,
  });

  Ship copyWith({
    String? image,
    bool? active,
    String? homePort,
    String? id,
    List<Mission>? missions,
    String? name,
    String? yearBuilt,
  }) {
    return Ship(
      image: image ?? this.image,
      active: active ?? this.active,
      homePort: homePort ?? this.homePort,
      id: id ?? this.id,
      missions: missions ?? this.missions,
      name: name ?? this.name,
      yearBuilt: yearBuilt ?? this.yearBuilt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'active': active,
      'homePort': homePort,
      'id': id,
      'missions': missions?.map((x) => x.toMap()).toList(),
      'name': name,
      'yearBuilt': yearBuilt,
    };
  }

  factory Ship.fromMap(Map<String, dynamic> map) {
    return Ship(
      image: map['image'] ??
          "https://datoms.io/wp-content/uploads/2020/12/placeholder.png",
      active: map['active'],
      homePort: map['home_port'],
      id: map['id'],
      missions:
          List<Mission>.from(map['missions']?.map((x) => Mission.fromMap(x))),
      name: map['name'],
      yearBuilt: map['year_built'].toString() == "null"
          ? "N/A"
          : map['year_built'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ship.fromJson(String source) => Ship.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ship(image: $image, active: $active, homePort: $homePort, id: $id, missions: $missions, name: $name, yearBuilt: $yearBuilt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ship &&
        other.image == image &&
        other.active == active &&
        other.homePort == homePort &&
        other.id == id &&
        listEquals(other.missions, missions) &&
        other.name == name &&
        other.yearBuilt == yearBuilt;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        active.hashCode ^
        homePort.hashCode ^
        id.hashCode ^
        missions.hashCode ^
        name.hashCode ^
        yearBuilt.hashCode;
  }
}

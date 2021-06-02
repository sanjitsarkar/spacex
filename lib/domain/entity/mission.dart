import 'dart:convert';

class Mission {
  final String flight;
  final String name;
  Mission({
    required this.flight,
    required this.name,
  });

  Mission copyWith({
    String? flight,
    String? name,
  }) {
    return Mission(
      flight: flight ?? this.flight,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'flight': flight,
      'name': name,
    };
  }

  factory Mission.fromMap(Map<String, dynamic> map) {
    return Mission(
      flight: map['flight'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Mission.fromJson(String source) => Mission.fromMap(json.decode(source));

  @override
  String toString() => 'Mission(flight: $flight, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Mission &&
      other.flight == flight &&
      other.name == name;
  }

  @override
  int get hashCode => flight.hashCode ^ name.hashCode;
}
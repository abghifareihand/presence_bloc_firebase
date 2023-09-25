class UserModel {
  final String address;
  final String createdAt;
  final String email;
  final String name;
  final String nip;
  final Position position;
  final String role;
  final String uid;

  UserModel({
    required this.address,
    required this.createdAt,
    required this.email,
    required this.name,
    required this.nip,
    required this.position,
    required this.role,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      address: json['address'] ?? '',
      createdAt: json['createdAt'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      nip: json['nip'] ?? '',
      position: Position.fromMap(json['position'] ?? {}),
      role: json['role'] ?? '',
      uid: json['uid'] ?? '',
    );
  }
}

class Position {
  final double lat;
  final double lng;

  Position({
    required this.lat,
    required this.lng,
  });

  factory Position.fromMap(Map<String, dynamic> map) {
    return Position(
      lat: (map['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (map['lng'] as num?)?.toDouble() ?? 0.0,
    );
  }
}


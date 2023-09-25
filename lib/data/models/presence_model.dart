class PresenceModel {
  final String date;
  final PresenceDetailModel? keluar;
  final PresenceDetailModel? masuk;

  PresenceModel({
    required this.date,
    this.keluar,
    this.masuk,
  });

  factory PresenceModel.fromJson(Map<String, dynamic> json) {
    return PresenceModel(
      date: json['date'],
      keluar: json['keluar'] != null ? PresenceDetailModel.fromJson(json['keluar']) : null,
      masuk: json['masuk'] != null ? PresenceDetailModel.fromJson(json['masuk']) : null,
    );
  }
}

class PresenceDetailModel {
  final String address;
  final String date;
  final double distance;
  final double lat;
  final double lng;
  final String status;

  PresenceDetailModel({
    required this.address,
    required this.date,
    required this.distance,
    required this.lat,
    required this.lng,
    required this.status,
  });

  factory PresenceDetailModel.fromJson(Map<String, dynamic> json) {
    return PresenceDetailModel(
      address: json['address'] ?? '',
      date: json['date'] ?? '',
      distance: json['distance'] != null ? json['distance'].toDouble() : 0.0,
      lat: json['lat'] != null ? json['lat'].toDouble() : 0.0,
      lng: json['lng'] != null ? json['lng'].toDouble() : 0.0,
      status: json['status'] ?? '',
    );
  }
}

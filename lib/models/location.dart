class Location {
  String postalCode;
  String country;
  String address;
  double latitude;
  double longitude;

  Location({
    required this.address,
    required this.country,
    required this.postalCode,
    required this.longitude,
    required this.latitude,
  });

  factory Location.fromJson(Map<String, dynamic> data) {
    return Location(
      address: data['address'],
      country: data['country'],
      postalCode: data['postalCode'],
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'country': country,
      'postalCode': postalCode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

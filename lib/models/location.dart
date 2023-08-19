class MyLocation {
  String postalCode;
  String country;
  String address;
  String city;
  double latitude;
  double longitude;

  MyLocation({
    required this.postalCode,
    required this.country,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory MyLocation.fromMap(Map<String, dynamic> map) {
    return MyLocation(
      postalCode: map['postalCode'] as String,
      country: map['country'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postalCode': postalCode,
      'country': country,
      'address': address,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  MyLocation copyWith({
    String? postalCode,
    String? country,
    String? address,
    String? city,
    double? latitude,
    double? longitude,
  }) {
    return MyLocation(
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      address: address ?? this.address,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  String toString() {
    return 'MyLocation(postalCode: $postalCode, country: $country, address: $address, city: $city, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant MyLocation other) {
    if (identical(this, other)) return true;

    return other.postalCode == postalCode &&
        other.country == country &&
        other.address == address &&
        other.city == city &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return postalCode.hashCode ^
        country.hashCode ^
        address.hashCode ^
        city.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}

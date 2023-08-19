import 'package:book/models/service_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
class MapServiceData extends ServiceData {
  final GoogleMapController? controller;
  final Marker? marker;
  final Position? position;

  const MapServiceData({
    required this.controller,
    required this.marker,
    required this.position,
    required super.error,
    required super.isLoading,
  });

  @override
  MapServiceData copyWith({
    GoogleMapController? controller,
    Marker? marker,
    Position? position,
    String? error,
    bool? isLoading,
  }) {
    return MapServiceData(
      controller: controller ?? this.controller,
      marker: marker ?? this.marker,
      position: position ?? this.position,
      error: error ?? super.error,
      isLoading: isLoading ?? super.isLoading,
    );
  }
}

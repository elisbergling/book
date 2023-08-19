import 'package:book/models/map_service_data.dart';
import 'package:book/providers/location_providers.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MapService extends Notifier<MapServiceData> {
  @override
  MapServiceData build() {
    return const MapServiceData(
      controller: null,
      marker: null,
      position: null,
      error: '',
      isLoading: false,
    );
  }

  Future<void> onMapCreated({required GoogleMapController controller}) async {
    Position? position = ref.read(myCurrentPosition.notifier).state;
    position ??= await ref.read(locationProvider.notifier).getCurrentPosition();
    state = state.copyWith(controller: controller);
    state = state.copyWith(position: position);
  }

  Future<double> distanceBetween(LatLng start) async {
    return GeolocatorPlatform.instance.distanceBetween(
      start.latitude,
      start.longitude,
      state.position!.latitude,
      state.position!.longitude,
    );
  }

  void addMarker(double lat, double long) {
    MarkerId markerId = MarkerId('$lat + $long');
    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, long),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    );
    state = state.copyWith(marker: marker);
  }
}

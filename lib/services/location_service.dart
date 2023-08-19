import 'package:book/models/location.dart';
import 'package:book/services/service_notifier.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService extends ServiceNotifier {
  Future<void> reguestLocationPermission() async {
    try {
      toggleLoading();
      bool permission = await Geolocator.isLocationServiceEnabled();
      if (!permission) await Geolocator.requestPermission();
    } catch (e) {
      setError(e);
    } finally {
      toggleLoading();
    }
  }

  Future<Position?> getCurrentPosition() async {
    try {
      toggleLoading();
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      setError(e);
      return null;
    } finally {
      toggleLoading();
    }
  }

  Future<MyLocation?> getLocation({
    required double lat,
    required double lon,
  }) async {
    try {
      toggleLoading();
      List<Placemark> places =
          await GeocodingPlatform.instance.placemarkFromCoordinates(lat, lon);
      Placemark mark = places.single;
      MyLocation location = MyLocation(
        latitude: lat,
        longitude: lon,
        country: mark.country ?? 'Unknown',
        postalCode: mark.postalCode ?? 'Unknown',
        address: mark.thoroughfare ?? 'Unknown',
        city: mark.locality ?? 'Unknown',
      );
      return location;
    } catch (e) {
      setError(e);
      return null;
    } finally {
      toggleLoading();
    }
  }
}

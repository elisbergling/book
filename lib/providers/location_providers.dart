import 'package:book/models/service_data.dart';
import 'package:book/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final locationProvider =
    NotifierProvider<LocationService, ServiceData>(() => LocationService());

final currentPosition = FutureProvider<Position?>((ref) async {
  final position =
      await ref.watch(locationProvider.notifier).getCurrentPosition();
  if (position != null) ref.read(myCurrentPosition.notifier).state = position;
  return position;
});

final myCurrentPosition = StateProvider<Position?>((_) => null);

import 'package:book/models/map_service_data.dart';
import 'package:book/services/map_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mapProvider =
    NotifierProvider<MapService, MapServiceData>(() => MapService());

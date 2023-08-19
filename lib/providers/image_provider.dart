import 'package:book/models/service_data.dart';
import 'package:book/services/image_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageProvider =
    NotifierProvider<ImageService, ServiceData>(() => ImageService());

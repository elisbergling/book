import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:book/models/service_data.dart';

abstract class ServiceNotifier extends Notifier<ServiceData> {
  @override
  ServiceData build() {
    return const ServiceData(
      error: '',
      isLoading: false,
    );
  }

  void toggleLoading() {
    state = state.toggle();
  }

  void setError(Object error) {
    if (kDebugMode) print(error);
    state = state.setError(error: error);
  }
}

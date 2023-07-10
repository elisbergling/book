import 'package:hooks_riverpod/hooks_riverpod.dart';

final navigationBarIndexProvider = StateProvider<int>(((_) => 0));

final profileListTypeIndexProvider = StateProvider<int>(((_) => 0));

final exploreTypeIsListProvider = StateProvider<bool>((_) => true);

import 'package:hooks_riverpod/hooks_riverpod.dart';

final navigationBarIndexProvider = StateProvider<int>(((_) => 0));

final profileListTypeIndexProvider = StateProvider<int>(((_) => 0));

final exploreTypeIsListProvider = StateProvider<bool>((_) => true);

final queryTextProvider = StateProvider<String>((_) => '');

final isBuyProvider = StateProvider<bool>((_) => true);

final isRentProvider = StateProvider<bool>((_) => true);

final isSwapProvider = StateProvider<bool>((_) => true);

final uploadProgressProcentProvider = StateProvider<double>((_) => 0);

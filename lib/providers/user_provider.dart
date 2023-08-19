import 'package:book/models/service_data.dart';
import 'package:book/models/user.dart';
import 'package:book/services/user_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider =
    NotifierProvider<UserService, ServiceData>(() => UserService());

final conversationStreamProvider = StreamProvider<List<MyUser>>((ref) {
  return ref.watch(userProvider.notifier).conversationUsersStream();
});

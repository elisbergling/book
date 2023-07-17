import 'package:book/providers/auth_provider.dart';
import 'package:book/services/user_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider = ChangeNotifierProvider<UserService?>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  return UserService(uid: auth.value?.uid);
});

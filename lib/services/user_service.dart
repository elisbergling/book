import 'package:book/models/user.dart';
import 'package:book/providers/auth_provider.dart';
import 'package:book/providers/providers.dart';
import 'package:book/services/service_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService extends ServiceNotifier {
  late final String? uid = ref.watch(firebaseAuthProvider).currentUser?.uid;

  late final CollectionReference userCollection =
      ref.watch(firebaseFirestoreProvider).collection('users');

  Stream<MyUser> userStream() {
    try {
      return userCollection
          .doc(uid)
          .snapshots()
          .map((doc) => MyUser.fromMap(doc));
    } catch (e) {
      setError(e);
      return const Stream.empty();
    }
  }

  Stream<List<MyUser>> usersStream({required String name}) {
    try {
      return userCollection
          .where('username', isEqualTo: name)
          .snapshots()
          .map((event) => event.docs.map((e) => MyUser.fromMap(e)).toList());
    } catch (e) {
      setError(e);
      return Stream.value([]);
    }
  }

  Stream<List<MyUser>> conversationUsersStream() {
    try {
      return userCollection
          .where('conversationUids', arrayContains: uid)
          .snapshots()
          .map((event) => event.docs.map((e) => MyUser.fromMap(e)).toList());
    } catch (e) {
      setError(e);
      return Stream.value([]);
    }
  }

  Future<MyUser?> myUserFuture() async {
    return userFuture(uid: uid!);
  }

  Future<MyUser?> userFuture({required String uid}) async {
    try {
      toggleLoading();
      final userJson = await userCollection.doc(uid).get();
      if (!userJson.exists) throw Exception();
      return MyUser.fromMap(userJson);
    } catch (e) {
      setError(e);
      return null;
    } finally {
      toggleLoading();
    }
  }

  Future<List<MyUser>?> getUsersFuture({required String name}) async {
    try {
      toggleLoading();
      return await userCollection
          .where('username', isEqualTo: name)
          .get()
          .then((event) => event.docs.map((e) => MyUser.fromMap(e)).toList());
    } catch (e) {
      setError(e);
      return null;
    } finally {
      toggleLoading();
    }
  }

  Future<void> createUser({required MyUser user}) async {
    try {
      toggleLoading();
      await userCollection.doc(user.uid).set(user.toMap());
    } catch (e) {
      setError(e);
      rethrow;
    } finally {
      toggleLoading();
    }
  }

  Future<void> updateUser({required MyUser user}) async {
    try {
      toggleLoading();
      await userCollection.doc(user.uid).update(user.toMap());
    } catch (e) {
      setError(e);
    } finally {
      toggleLoading();
    }
  }

  Future<void> deleteUser() async {
    try {
      toggleLoading();
      await userCollection.doc(uid).delete();
    } catch (e) {
      setError(e);
    } finally {
      toggleLoading();
    }
  }
}

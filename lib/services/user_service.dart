import 'package:book/models/user.dart';
import 'package:book/providers/image_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserService with ChangeNotifier {
  UserService({
    required this.uid,
  });
  final String? uid;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String error = '';

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<MyUser>? userStream() {
    try {
      return userCollection
          .doc(uid)
          .snapshots()
          .map((doc) => MyUser.fromJson(doc));
    } on Exception catch (exception, _) {
      print(exception);
      error = exception.toString();
      notifyListeners();
      return null;
    }
  }

  Stream<List<MyUser>>? usersStream({required String name}) {
    try {
      return userCollection
          .where('username', isEqualTo: name)
          .snapshots()
          .map((event) => event.docs.map((e) => MyUser.fromJson(e)).toList());
    } on Exception catch (exception, _) {
      print(exception);
      error = exception.toString();
      notifyListeners();
      return null;
    }
  }

  Future<List<MyUser>?> usersFuture({required String name}) async {
    try {
      _isLoading = true;
      notifyListeners();
      return await userCollection
          .where('username', isEqualTo: name)
          .get()
          .then((event) => event.docs.map((e) => MyUser.fromJson(e)).toList());
    } on Exception catch (exception, _) {
      print(exception);
      error = exception.toString();
      notifyListeners();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<MyUser?> getUserFuture() async {
    try {
      _isLoading = true;
      notifyListeners();
      final userJson = await userCollection.doc(uid).get();
      return MyUser.fromJson(userJson);
    } on Exception catch (exception, _) {
      print(exception);
      error = exception.toString();
      notifyListeners();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUser() async {
    try {
      _isLoading = true;
      notifyListeners();
      await userCollection.doc(uid).delete();
    } on Exception catch (exception, _) {
      print(exception);
      error = exception.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateImgUrl() async {
    try {
      _isLoading = true;
      notifyListeners();
      String? url =
          await ProviderContainer().read(imageProvider).getDownloadUrl(uid!);
      if (url == null) {
        throw Exception('No url');
      }
      await userCollection.doc(uid).update({
        'profileImageUrl': url,
      });
    } on Exception catch (exception, _) {
      print(exception);
      error = exception.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateName({
    required String name,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      await userCollection.doc(uid).update({
        'name': name,
      });
    } on Exception catch (exception, _) {
      print(exception);
      error = exception.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

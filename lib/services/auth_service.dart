import 'package:book/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  AuthService({
    required this.auth,
  });

  final FirebaseAuth auth;

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _error;
  String? get error => _error;
  set error(error) => _error = error;

  Future<void> createUser({required MyUser user}) async {
    try {
      _isLoading = true;
      notifyListeners();
      await userCollection.doc(user.uid).set(user.toJson());
    } on Exception catch (exception, _) {
      print(exception);
      _error = exception.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    try {
      _isLoading = true;
      notifyListeners();
      await auth.signOut();
    } on Exception catch (exception, _) {
      print(exception);
      _error = exception.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      final res = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return res.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        _error = 'Wrong password provided for that user.';
      }
      notifyListeners();
      return null;
    } on Exception catch (exception, _) {
      print(exception);
      _error = exception.toString();
      notifyListeners();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> signUpAnonymously() async {
    try {
      _isLoading = true;
      notifyListeners();
      final res = await auth.signInAnonymously();
      return res.user;
    } on Exception catch (exception, _) {
      print(exception);
      _error = exception.toString();
      notifyListeners();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      final res = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return res.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        _error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        _error = 'The account already exists for that email.';
      }
      notifyListeners();
      return null;
    } on Exception catch (exception, _) {
      print(exception);
      _error = exception.toString();
      notifyListeners();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<User?> signUpWithGoogle() async {
    try {
      _isLoading = true;
      notifyListeners();
      GoogleSignIn gs = GoogleSignIn();
      final googleUser = await gs
          .signIn()
          .onError((error, stackTrace) => throw Exception(error.toString()));
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final res = await auth.signInWithCredential(credential);
      return res.user;
    } on Exception catch (exception, _) {
      print(exception);
      _error = exception.toString();
      notifyListeners();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

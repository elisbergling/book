import 'package:book/mock/mock_locations.dart';
import 'package:book/models/service_data.dart';
import 'package:book/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthService extends Notifier<ServiceData> {
  @override
  ServiceData build() {
    return const ServiceData(
      error: '',
      isLoading: false,
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  void toggleLoading() {
    state = state.copyWith(isLoading: !state.isLoading);
  }

  void setError(String error) {
    print(error);
    state = state.copyWith(error: error);
  }

  Future<void> logOut() async {
    try {
      toggleLoading();
      await auth.signOut();
    } on Exception catch (exception, _) {
      setError(exception.toString());
    } finally {
      toggleLoading();
    }
  }

  Future<User?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      toggleLoading();
      final res = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return res.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setError('Wrong password provided for that user.');
      }
      return null;
    } on Exception catch (exception, _) {
      setError(exception.toString());
      return null;
    } catch (e) {
      setError(e.toString());
      return null;
    } finally {
      toggleLoading();
    }
  }

  Future<User?> signUpAnonymously() async {
    try {
      toggleLoading();
      final res = await auth.signInAnonymously();
      return res.user;
    } on Exception catch (exception, _) {
      setError(exception.toString());
      return null;
    } finally {
      toggleLoading();
    }
  }

  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String username,
  }) async {
    try {
      toggleLoading();
      final res = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser user = MyUser(
        uid: res.user!.uid,
        name: name,
        username: username,
        email: email,
        bookIds: [],
        followingUserIds: [],
        location: mockLocations[0],
        profileImageUrl: '',
      );
      await userCollection.doc(res.user?.uid).set(user.toJson());
      return res.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        setError('The account already exists for that email.');
      }
      return null;
    } on Exception catch (exception, _) {
      setError(exception.toString());
      return null;
    } catch (e) {
      setError(e.toString());
      return null;
    } finally {
      toggleLoading();
    }
  }

  Future<User?> signUpWithGoogle() async {
    try {
      toggleLoading();
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
      setError(exception.toString());

      return null;
    } finally {
      toggleLoading();
    }
  }
}

import 'package:book/models/user.dart';
import 'package:book/providers/auth_provider.dart';
import 'package:book/providers/user_provider.dart';
import 'package:book/services/service_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ServiceNotifier {
  late final FirebaseAuth auth = ref.watch(firebaseAuthProvider);

  Future<void> logOut() async {
    try {
      toggleLoading();
      await auth.signOut();
    } catch (e) {
      setError(e);
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
      final UserCredential res = await auth.signInWithEmailAndPassword(
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
    } catch (e) {
      setError(e);
      return null;
    } finally {
      toggleLoading();
    }
  }

  Future<User?> signUpAnonymously() async {
    try {
      toggleLoading();
      final UserCredential res = await auth.signInAnonymously();
      return res.user;
    } catch (e) {
      setError(e);
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
      final UserCredential res = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser user = MyUser(
        uid: res.user!.uid,
        name: name,
        username: username,
        email: email,
        followingUids: [],
        conversationUids: [],
        profileImageUrl: '',
      );
      await ref.read(userProvider.notifier).createUser(user: user);
      return res.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        setError('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      setError(e);
      return null;
    } finally {
      toggleLoading();
    }
  }

  Future<User?> signUpWithGoogle() async {
    try {
      toggleLoading();
      GoogleSignIn gs = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await gs.signIn().onError(
          (Object? error, StackTrace stackTrace) =>
              throw Exception(error.toString()));
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential res = await auth.signInWithCredential(credential);
      final user =
          await ref.read(userProvider.notifier).userFuture(uid: res.user!.uid);
      if (user != null) {
        MyUser myUser = MyUser(
          uid: res.user!.uid,
          name: res.user!.displayName!,
          username: res.user!.email!,
          email: res.user!.email!,
          profileImageUrl: res.user!.photoURL!,
          followingUids: [],
          conversationUids: [],
        );
        await ref.read(userProvider.notifier).createUser(user: myUser);
      }
      return res.user;
    } catch (e) {
      setError(e);
      return null;
    } finally {
      toggleLoading();
    }
  }
}

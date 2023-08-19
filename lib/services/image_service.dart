import 'dart:io';

import 'package:book/providers/auth_provider.dart';
import 'package:book/providers/state_provider.dart';
import 'package:book/services/service_notifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageService extends ServiceNotifier {
  late final String? uid = ref.watch(firebaseAuthProvider).currentUser?.uid;
  static final Reference referance = FirebaseStorage.instance.ref();
  Reference userRef = referance.child('users/');
  Reference bookRef = referance.child('books/');
  Reference messageRef = referance.child('messages/');
  ImagePicker imagePicker = ImagePicker();

  Future<XFile?> takePhoto({
    required ImageSource imageSource,
  }) async {
    try {
      toggleLoading();
      XFile? file = await imagePicker.pickImage(source: imageSource);
      if (file == null) {
        throw Exception('No file was selected');
      }
      return file;
    } catch (e) {
      setError(e);
      return null;
    } finally {
      toggleLoading();
    }
  }

  Future<String?> _uploadFile({
    required XFile file,
    required Reference referenceName,
    int index = 0,
    int amount = 1,
  }) async {
    try {
      toggleLoading();
      String? url;
      referenceName.putFile(File(file.path)).snapshotEvents.listen((event) {
        ref.read(uploadProgressProcentProvider.notifier).state =
            (index / amount) +
                ((event.bytesTransferred / event.totalBytes) / amount);
      }).onDone(() async {
        ref.read(uploadProgressProcentProvider.notifier).state = 0;
        url = await referenceName.getDownloadURL();
      });
      return url;
    } catch (e) {
      setError(e);
      return null;
    } finally {
      toggleLoading();
    }
  }

  Future<String?> uploadUser({required XFile file}) async {
    return await _uploadFile(file: file, referenceName: userRef.child(uid!));
  }

  Future<String?> uploadBook({
    required XFile file,
    required String id,
    required int index,
    required int amount,
  }) async {
    return await _uploadFile(
      file: file,
      referenceName: bookRef.child('$id/$index'),
      index: index,
      amount: amount,
    );
  }

  Future<String?> uploadMessage({
    required XFile file,
    required String id,
  }) async {
    return await _uploadFile(file: file, referenceName: messageRef.child(id));
  }

  Future<void> _deleteFile({required Reference referenceName}) async {
    try {
      toggleLoading();
      await referenceName.delete();
    } catch (e) {
      setError(e);
    } finally {
      toggleLoading();
    }
  }

  Future<void> deleteUserFile() async {
    await _deleteFile(referenceName: userRef.child(uid!));
  }

  Future<void> deleteBookFile({
    required String id,
    required int index,
  }) async {
    await _deleteFile(referenceName: bookRef.child(id).child(index.toString()));
  }

  Future<void> deleteMessageFile({required String id}) async {
    await _deleteFile(referenceName: messageRef.child(id));
  }
}

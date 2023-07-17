import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _error = '';
  String get error => _error;

  Reference referance = FirebaseStorage.instance.ref();

  Future<void> uploadFile(
    String uid,
    ImageSource imageSource,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();
      Reference ref = referance.child(uid);
      XFile? file = await ImagePicker().pickImage(source: imageSource);
      if (file == null) {
        print("No file was selected");
        return;
      }
      ref.putFile(File(file.path));
      //     .then((_) async => await ProviderContainer()
      //         .read(userProvider)
      //         .updateImgUrl(uid: uid))
      //     .onError((error, stackTrace) {
      //   print('error: ' +
      //       error.toString() +
      //       'stackTrace: ' +
      //       stackTrace.toString());
      //   _error = error.toString();
      //   notifyListeners();
      // });
    } on Exception catch (exception, _) {
      print(exception);
      _error = exception.toString();
      notifyListeners();
      return;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> getDownloadUrl(String uid) async {
    try {
      _isLoading = true;
      notifyListeners();
      Reference ref = FirebaseStorage.instance.ref().child(uid);
      String url = await ref.getDownloadURL();
      return url;
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

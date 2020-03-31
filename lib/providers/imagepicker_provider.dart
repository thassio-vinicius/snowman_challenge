import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  File _image;
  ImageSource _imageSource;
  String _imageUrl;

  File get image => _image;
  ImageSource get imageSource => _imageSource;
  String get imageUrl => _imageUrl;

  set imageSource(ImageSource source) {
    _imageSource = source;

    notifyListeners();
  }

  set image(File image) {
    _image = image;

    notifyListeners();
  }

  uploadImage({File image}) async {
    StorageReference reference =
        FirebaseStorage.instance.ref().child('mainPictures/${image.path}');
    StorageUploadTask uploadTask = reference.putFile(image);
    await uploadTask.onComplete;
    print('uploaded');
    reference.getDownloadURL().then((value) => _imageUrl = value);
  }
}

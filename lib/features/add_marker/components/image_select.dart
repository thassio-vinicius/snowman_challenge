import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/providers/imagepicker_provider.dart';
import 'package:snowmanchallenge/shared/components/custom_button.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class ImageSelect extends StatefulWidget {
  @override
  _ImageSelectState createState() => _ImageSelectState();
}

class _ImageSelectState extends State<ImageSelect> {
  ImagePickerProvider _imageProvider;

  @override
  void didChangeDependencies() {
    _imageProvider = Provider.of<ImagePickerProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(
          Icons.camera_alt,
          color: HexColor('#10159A'),
        ),
        onPressed: () async => await showDialog(
          context: context,
          builder: (context) => _imagePicker(),
        ),
      ),
    );
  }

  _imagePicker() {
    return Theme(
      data: ThemeData.light(),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        title: Text(
          "Where's your image coming from?",
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: HexColor('#111236'),
            ),
          ),
        ),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(
                onTap: () => _onTap(ImageSource.camera),
                margin: EdgeInsets.symmetric(horizontal: 12),
                label: 'Camera',
                percentageWidth: 0.20),
            CustomButton(
                onTap: () => _onTap(ImageSource.gallery),
                margin: EdgeInsets.symmetric(horizontal: 12),
                label: 'Gallery',
                percentageWidth: 0.20),
          ],
        ),
      ),
    );
  }

  _setCurrentImage() async {
    ImageSource source = _imageProvider.imageSource;

    File image = await ImagePicker.pickImage(source: source);

    _imageProvider.image = image;
  }

  _onTap(ImageSource source) async {
    _imageProvider.imageSource = source;

    await _setCurrentImage();

    Navigator.pop(context);
  }
}

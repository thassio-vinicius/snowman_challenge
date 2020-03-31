import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snowmanchallenge/features/add_marker/components/custom_button.dart';
import 'package:snowmanchallenge/providers/imagepicker_provider.dart';
import 'package:snowmanchallenge/utils/hexcolor.dart';

class CustomImagePicker extends StatefulWidget {
  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  _setCurrentImage() async {
    ImageSource source =
        Provider.of<ImagePickerProvider>(context, listen: false).imageSource;

    File image = await ImagePicker.pickImage(source: source);

    Provider.of<ImagePickerProvider>(context, listen: false).image = image;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
    );
  }

  _onTap(ImageSource source) async {
    var imageProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);

    imageProvider.imageSource = source;

    await _setCurrentImage();

    Navigator.pop(context);
  }
}

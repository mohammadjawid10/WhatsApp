import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source);

  if(file != null) {
    return await file.readAsBytes();

    //! this method can also be done the way below
    // return File(file.path);
  }
  log('Utils - No image selected');
}











showSnackBar(BuildContext context, String text) {
  SnackBar snackBar = SnackBar(content: Text(text));

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
}



import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async{
  final ImagePicker _picker = ImagePicker();

  XFile? _file = await _picker.pickImage(source: source);
  if(_file != null){
    return await _file.readAsBytes();
  }
  print('No image selected.');
}

showSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}
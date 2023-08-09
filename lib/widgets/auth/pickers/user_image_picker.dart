import 'dart:io';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function pickImgFn;

  UserImagePicker(this.pickImgFn);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? pickedImage;

  void pickImage() async {
    final pickedimg = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 150,
      maxWidth: 150,
    );
    setState(() {
      pickedImage = File(pickedimg!.path);
    });
    widget.pickImgFn(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.18,
            backgroundImage: pickedImage != null
                ? FileImage(
                    pickedImage!,
                  )
                : AssetImage('assets/images/auth-locked.png') as ImageProvider,
          ),
          Positioned(
            top: MediaQuery.of(context).size.width * 0.20,
            right: -MediaQuery.of(context).size.width * 0,
            child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 111, 131, 247),
              // radius: 8,

              child: IconButton(
                icon: Icon(
                  FluentIcons.camera_16_filled,
                  color: Colors.white,
                ),
                onPressed: pickImage,
              ),

              // label: Text(
              //   'Add Image',
              //   style: TextStyle(
              //     color: Theme.of(context).primaryColor,
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

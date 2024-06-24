// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:green_campus_app/app/data/helpers/assets.dart';
import 'package:green_campus_app/app/data/helpers/themes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

getImage(ImageSource source) async {
  try {
    return await ImagePicker().pickImage(source: source);
  } catch (e) {
    Get.snackbar("Error", e.toString());
  }
}

Future<XFile?> imagePickerBottomSheet(BuildContext context) async {
  XFile? result;

  await showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) => Container(
      height: 200,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 16, left: 16),
            child: Text("Image Source"),
          ),
          ListTile(
              title: Text("Camera"),
              leading: Icon(
                Icons.camera,
                color: primaryColor(context),
              ),
              onTap: () async {
                result = await getImage(ImageSource.camera);
                Get.back();
              }),
          ListTile(
              title: Text("Gallery"),
              leading: Icon(
                Icons.photo,
                color: primaryColor(context),
              ),
              onTap: () async {
                result = await getImage(ImageSource.gallery);
                Get.back();
              }),
        ],
      ),
    ),
  );
  return result;
}

class GCFormFoto extends StatelessWidget {
  String oldPath = '';
  String defaultPath;
  bool showButton = true;
  bool showFrame;
  bool forceCamera;
  double? height;
  double? width;
  GCFormFoto({
    this.oldPath = '',
    this.defaultPath = img_placeholder,
    this.showButton = true,
    this.showFrame = false,
    this.forceCamera = false,
    this.height,
    this.width,
  });
  // final ImagePicker _picker = ImagePicker();
  var xfoto = ''.obs;
  String get newPath => xfoto.value;

  // getImage(ImageSource source) async {
  //   var result = await _picker.pickImage(source: source);
  //   // if (result is XFile) {
  //   //   xfoto.value = result.path;
  //   // }
  //   if (result is XFile) {
  //     xfoto.value = result.path;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => Container(
            alignment: Alignment.center,
            margin: !showButton ? null : EdgeInsets.only(bottom: 16),
            height: height,
            width: width,
            decoration: showFrame
                ? boxDecorationDefault(borderRadius: BorderRadius.circular(16))
                : null,
            constraints: BoxConstraints(maxHeight: 200),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: newPath.isNotEmpty
                  ? Image.file(File(newPath))
                  : oldPath.isNotEmpty
                      ? Image.network(
                          oldPath,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          defaultPath,
                        ),
            ),
          ),
        ),
        if (showButton)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24))),
            child: Text(
              "Upload Foto",
            ),
            onPressed: () async {
              var res = forceCamera
                  ? await getImage(ImageSource.camera)
                  : await imagePickerBottomSheet(context);
              if (res is XFile) {
                xfoto.value = res.path;
              }
            },
          ),
      ],
    );
  }
}

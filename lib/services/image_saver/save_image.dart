import 'dart:typed_data';
import 'package:energy_graphs/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<void> saveImageToGallery(
  BuildContext context,
  Uint8List bytes,
  String imageName,
) async {
  final Map result = await ImageGallerySaver.saveImage(
    bytes,
    name: imageName,
  );
  result.forEach((key, value) {
    if (key == "isSuccess" && value == true) {
      showToast(context, "Сохранено в галерею");
    }
  });
}

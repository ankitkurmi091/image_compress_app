// compress logic and save file

import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class CompressLogic{
  Future<void> resizeImageToTargetSize(String inputImagePath, int targetFileSizeKB) async {

    final inputFile = File(inputImagePath);
    final inputImageBytes = await inputFile.readAsBytes();
    // int check = int.parse(inputImageBytes as String);
    // file outputFile.lengthSync() / 1024;
    final inputFile01 = File(inputImagePath);
    final fileSizeKB = inputFile01.lengthSync() / 1024;
    if(fileSizeKB<targetFileSizeKB){
      Fluttertoast.showToast(
        msg: "File size less than compressed size",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    Fluttertoast.showToast(
      msg: "Please wait",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    int quality = 100;
    bool sizeAchieved = false;
    DateTime timeOnly = DateTime.now();

    String formattedTime = '${timeOnly.hour.toString().padLeft(2, '0')}${timeOnly.minute.toString().padLeft(2, '0')}${timeOnly.second.toString().padLeft(2, '0')}';
    String outputFile = 'File$formattedTime-compressed.jpg';
    // String output_file = '/File$timeOnly+compressed.jpg';


    // String outputImagePath = path.join(tempDirPath, outputFile);
    String outputImagePath = '$inputImagePath$outputFile';

    // String outputImagePath = {tempDir.path}output_file;

    while (!sizeAchieved && quality > 0) {
      final compressedImageBytes = await FlutterImageCompress.compressWithList(
        inputImageBytes,
        quality: quality,
      );

      final outputFile = File(outputImagePath);
      await outputFile.writeAsBytes(compressedImageBytes);

      final fileSizeKB = outputFile.lengthSync() / 1024;
      print('Current file size: $fileSizeKB KB');

      if (fileSizeKB <= targetFileSizeKB) {
        sizeAchieved = true;
      } else {
        quality = (quality - 5).clamp(0, 100);
      }
    }

    if (!sizeAchieved) {
      print('Could not achieve the target file size.');
    } else {
      // Save the image to the gallery
      final result = await ImageGallerySaver.saveFile(outputImagePath);
      if (result['isSuccess']) {
        print('Image saved to gallery');
        Fluttertoast.showToast(
          msg: "File Saved in Gallery",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // inputImagePath == null;

      } else {
        print('Failed to save image to gallery');
      }

    }
  }

  Future<void> selectAndCompressImage(int targetFileSizeKB) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      await resizeImageToTargetSize(pickedFile.path, targetFileSizeKB);
    } else {
      print('No image selected');
    }
  }
}

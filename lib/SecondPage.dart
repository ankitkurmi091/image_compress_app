// Second screen code

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_compress_app/Compress_Image.dart';
import 'package:image_compress_app/Factory.dart';
import 'package:image_compress_app/FunctionCalling.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'ImageChose.dart';

class SecondPage extends StatefulWidget {
  @override
  SecondPage1 createState() => SecondPage1();
}

class SecondPage1 extends State<SecondPage> {

  @override
  Widget build(BuildContext context) {
    final TextEditingController imageSizeUser = TextEditingController();
    String imageSizeText = "";
    int sizeUser = 100;
    String file = "";
    Factory1 obj = Factory1();
    FunctionClass1 functionObj = obj.methodFunction();
    ImageChose choseObj = obj.method_image_chose();
    Factory1 objectFactory = Factory1();
    FunctionClass1 functionClassObj = objectFactory.methodFunction();
    CompressLogic compressObj = CompressLogic();

    String errorMessage = '';
    String pathUser = functionClassObj.function2();

    void saveText() {
      setState(() {
        imageSizeText = imageSizeUser.text;
      });
      // print('Stored text: $imageSizeText');
    }

    void validateInput() {
      setState(() {
        int? value = int.tryParse(imageSizeUser.text);
        if(value == null){
          print ('null');
        }
        else if (value < 1 || value > 1000) {
          errorMessage = 'Please enter a number between 1 and 1000';
        }
        else {
          errorMessage = '';
        }
      });
    }

    void performTaskAndClear() {
      setState(() {
        imageSizeUser.clear();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compress Image'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 70, right: 70),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                  child: pathUser != null
                      ? Image.file(File(pathUser)) // Display the image from the file path.
                      : const Text('No image selected.'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 43),
                child: ElevatedButton(
                  onPressed: () async {
                    file = await choseObj.imageFromGallery();
                    if (file.isEmpty) {
                      print('file not found');
                      Fluttertoast.showToast(
                        msg: 'Select Image',
                        backgroundColor: Colors.grey,
                      );
                    } else {
                      functionObj.function1(file);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SecondPage()));
                      print('file present................................ $file');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  child: const Text(
                    'Chose Image',
                    style: TextStyle(color: Colors.white), // Specify color here for clarity
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                  child: const Text(
                    '  Enter the desired size in KB  ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.5),
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.white, // Text color
                      ),
                      autofocus: true,
                      controller: imageSizeUser,
                      decoration: const InputDecoration(
                        hintText: '100     KB',
                        hintStyle: TextStyle(
                          color: Colors.white, // Change hint text color here
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    saveText();
                    validateInput();
                    performTaskAndClear;

                    if (errorMessage.isEmpty) {
                      // Perform actions if the input is valid
                      print('Valid input: ${imageSizeUser.text}');
                    } else{
                      print('wrong input ...');
                      Fluttertoast.showToast(
                        msg: "Select valid size",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }

                    print(imageSizeText);

                    // if (image_size_text == null) {
                    //   size_user = 100;
                    // } else {
                    //   size_user = int.parse(image_size_text);
                    // }

                    if (imageSizeText == null || imageSizeText.isEmpty) {
                      sizeUser = 100; // Default value if input is null
                    } else {
                      try {
                        sizeUser = int.parse(imageSizeText);
                      } catch (e) {
                        sizeUser = 100; // Fallback to default if parsing fails
                        // print('Invalid input: $e');
                      }
                    }

                    // print('path ......................$path_user');
                    compressObj.resizeImageToTargetSize(pathUser, sizeUser);
                    FocusManager.instance.primaryFocus?.unfocus();

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  child: const Text(
                    'compress',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

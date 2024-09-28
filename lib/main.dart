//This file for first page
import 'package:flutter/material.dart';
import 'package:image_compress_app/Factory.dart';
import 'package:image_compress_app/FunctionCalling.dart';
import 'package:image_compress_app/ImageChose.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_compress_app/SecondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Compress App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Image Compress'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    Factory1 obj = Factory1();
    FunctionClass1 function_obj = obj.methodFunction();
    ImageChose choseObj = obj.method_image_chose();


    String file;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(title),
        actions: [
          IconButton(onPressed: () async {
           ImagePicker picker = ImagePicker();
           XFile? file1 = await picker.pickImage(source: ImageSource.camera);
           if(file1 != null) {
             String? filePath = file1.path;
             print('123 gama.    ............$filePath');
             function_obj.function1(filePath);
             Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
             print('file present................................ $filePath');

           }
           else{
             print('null image ........');
             Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: title)));
           }


          }, icon: Icon(Icons.add_a_photo_outlined))
        ],
      ),
      body: Center(
        child: Container(
          color: const Color(0xFFF5F5F5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    file = await choseObj.imageFromGallery();
                    if(file.isEmpty){
                      print('file not found');
                      Fluttertoast.showToast(
                        msg: 'Select Image',
                        backgroundColor: Colors.grey,
                      );
                    }
                    else{
                      function_obj.function1(file);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
                      print('file present................................ $file');

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  child: const Text(
                    'Chose Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, left: 15, right: 15),
                child: Text(
                  'Please choose the image that you want to compress',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontSize: 25,
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

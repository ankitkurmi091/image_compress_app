// This file for chose image from Gallery
import 'package:image_picker/image_picker.dart';

class ImageChose{
  Future<String> imageFromGallery() async{
    String inputImage;
    final ImagePicker picker = ImagePicker();
    final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);

    if(xFile != null){
      inputImage = xFile.path;
      return inputImage;

    }
    else{
      return 'null';
    }
  }
}
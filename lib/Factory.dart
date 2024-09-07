// Pass Objects of classes

import 'package:image_compress_app/FunctionCalling.dart';
import 'package:image_compress_app/ImageChose.dart';

class Factory1{

  static FunctionClass1? check;
  static ImageChose? image_check;

  FunctionClass1 methodFunction() {
    if (check == null) {
      check = FunctionClass1();
    }
    return check!;
  }

  ImageChose method_image_chose(){
    if(image_check == null){
      image_check = ImageChose();
    }
    return image_check!;
  }
}
// File path transfer first screen to second screen

class FunctionClass1 {
  String path = '';

  void function1(String newPath) {
    path = newPath;
    // print('Path set to: $path');
  }

  String function2() {
    // print('In function2, current path is: $path');
    return path;
  }
}

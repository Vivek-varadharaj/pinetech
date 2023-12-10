
import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';

class ZoomAndPostionProvider extends ChangeNotifier {
  bool isLoading = false;

  bool? isLongPressAndMove;

  late double height;
  late double width;
  ZoomAndPostionProvider(BuildContext context) {
    height = MediaQuery.of(context).size.height - 200;
    width = MediaQuery.of(context).size.width - 40;
  }

  int? selectedIndex;
  List<MyImage> buildingList = [];
  List<MyImage> images = [
    MyImage(isSelected: false, position: const Offset(10, 10), scale: 1),
    MyImage(isSelected: false, position: const Offset(10, 120), scale: 1),
    MyImage(isSelected: false, position: const Offset(120, 10), scale: 1),
    MyImage(isSelected: false, position: const Offset(120, 120), scale: 1),
    MyImage(isSelected: false, position: const Offset(10, 240), scale: 1),
    MyImage(isSelected: false, position: const Offset(120, 240), scale: 1),
  ];

  void longPressMoveUpdate(
    MoveEvent details,
    MyImage image,
  ) async {
    selectedIndex = images.indexOf(image);
    isLongPressAndMove = true;
    notifyListeners();

    if (selectedIndex == images.indexOf(image)) {
      image.position += details.delta - details.localDelta;

      // Ensure the image stays within bounds
      image.position = Offset(
        image.position.dx.clamp(0.0 + ((100 * image.scale - 100) / 2),
            width - (100 * image.scale - (100 * image.scale - 100) / 2)),
        image.position.dy.clamp(0.0 + ((100 * image.scale - 100) / 2),
            height - (100 * image.scale - (100 * image.scale - 100) / 2)),
      );
    }

    notifyListeners();
  }

  void onInteraction(
    ScaleUpdateDetails details,
    MyImage image,
  ) {
    if (image.scale < 1.5 && selectedIndex == images.indexOf(image)) {
      image.position += details.focalPointDelta;

      // Ensure the image stays within bounds
      image.position = Offset(
        image.position.dx.clamp(0.0 + ((100 * image.scale - 100) / 2),
            width - (100 * image.scale - (100 * image.scale - 100) / 2)),
        image.position.dy.clamp(0.0 + ((100 * image.scale - 100) / 2),
            height - (100 * image.scale - (100 * image.scale - 100) / 2)),
      );
    }

    if (selectedIndex == images.indexOf(image)) {
      image.scale *= details.scale;

      image.scale = image.scale.clamp(1.0, 1.5);
    }

    notifyListeners();
  }

  void onLongPress(MyImage image) {
    selectedIndex = images.indexOf(image);
    notifyListeners();
  }
}

class MyImage {
  Offset position = const Offset(50.0, 50.0);
  double scale = 1.0;
  bool isSelected = false;

  MyImage(
      {required this.position, required this.scale, required this.isSelected});
}

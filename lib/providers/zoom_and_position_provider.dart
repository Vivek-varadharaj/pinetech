import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:http/http.dart';
import 'package:pinetech/models/product.dart';
import 'package:pinetech/providers/cart_provider.dart';
import 'package:pinetech/repositories/api_repository.dart';
import 'package:pinetech/screens/cart_canvas_screen.dart';
import 'package:pinetech/services/network_services.dart';
import 'package:pinetech/utils/app_constants.dart';
import 'package:provider/provider.dart';

class ZoomAndPostionProvider extends ChangeNotifier {
  bool isLoading = false;

  void longPressMoveUpdate(MoveEvent details, MyImage image) async {
    image.position += details.delta - details.localDelta;
    print(image.position.dx);
    print(300 - 100 * image.scale);
    // Ensure the image stays within bounds
    image.position = Offset(
      image.position.dx.clamp(0.0 + ((100 * image.scale - 100) / 2),
          300.0 - (100 * image.scale - (100 * image.scale - 100) / 2)),
      image.position.dy.clamp(0.0 + ((100 * image.scale - 100) / 2),
          400.0 - (100 * image.scale - (100 * image.scale - 100) / 2)),
    );

    notifyListeners();
  }
}

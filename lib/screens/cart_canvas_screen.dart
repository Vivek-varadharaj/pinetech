import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:pinetech/providers/cart_provider.dart';
import 'package:pinetech/providers/zoom_and_position_provider.dart';
import 'package:provider/provider.dart';

class CartCanvasScreen extends StatefulWidget {
  @override
  _CartCanvasScreenState createState() => _CartCanvasScreenState();
}

class _CartCanvasScreenState extends State<CartCanvasScreen> {
  // int? _selectedIndex;

  bool isScaleEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ZoomAndPostionProvider>(context, listen: false).images =
        Provider.of<ZoomAndPostionProvider>(context, listen: false)
            .images
            .sublist(
                0,
                Provider.of<CartProvider>(context, listen: false)
                    .cartProduct
                    .length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Container'),
      ),
      body: Consumer<ZoomAndPostionProvider>(builder: (context, zoom, child) {
        return Container(
          clipBehavior: Clip.hardEdge,
          height: 400.0,
          width: 300.0,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              ...zoom.images.map((image) {
                return Positioned(
                  left: image.position.dx,
                  top: image.position.dy,
                  child: XGestureDetector(
                    onDoubleTap: (event) {
                      setState(() {
                        image.scale = 1;
                      });
                    },
                    onLongPressMove: (details) {
                      zoom.longPressMoveUpdate(details, image);
                    },
                    onLongPress: (event) {
                      zoom.onLongPress(image);
                      HapticFeedback.selectionClick();
                    },
                    child: Transform.scale(
                      scale: image.scale,
                      child: Container(
                        color: zoom.selectedIndex == zoom.images.indexOf(image)
                            ? Colors.red
                            : Colors.white,
                        child: InteractiveViewer(
                          maxScale: 5,
                          scaleEnabled:
                              zoom.selectedIndex == zoom.images.indexOf(image),
                          panEnabled: true,
                          onInteractionUpdate: (details) {
                            {
                              zoom.onInteraction(details, image);
                            }
                          },
                          child: Image.network(
                            Provider.of<CartProvider>(context)
                                .cartProduct[zoom.images.indexOf(image)]
                                .imageUrl, // Replace with actual image URL
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      }),
    );
  }
}

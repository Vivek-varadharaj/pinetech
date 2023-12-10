import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:pinetech/providers/cart_provider.dart';
import 'package:pinetech/providers/zoom_and_position_provider.dart';
import 'package:provider/provider.dart';

class CartCanvasScreen extends StatefulWidget {
  const CartCanvasScreen({super.key});

  @override
  _CartCanvasScreenState createState() => _CartCanvasScreenState();
}

class _CartCanvasScreenState extends State<CartCanvasScreen> {
  // int? _selectedIndex;

  bool isScaleEnabled = false;

  @override
  void initState() { 
    super.initState();
    Provider.of<ZoomAndPostionProvider>(context, listen: false).buildingList =
        Provider.of<ZoomAndPostionProvider>(context, listen: false)
            .images
            .sublist(
                0,
                (Provider.of<CartProvider>(context, listen: false)
                    .cartProduct
                    .length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Categories",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
      body: Consumer<ZoomAndPostionProvider>(builder: (context, zoom, child) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: DottedBorder(
                    padding: EdgeInsets.zero,
                    strokeWidth: 1,
                    radius: const Radius.circular(10),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: MediaQuery.of(context).size.height - 200,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          ...zoom.buildingList.map((image) {
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
                                  zoom.longPressMoveUpdate(
                                    details,
                                    image,
                                  );
                                },
                                onLongPress: (event) {
                                  zoom.onLongPress(image);
                                  HapticFeedback.selectionClick();
                                },
                                child: Transform.scale(
                                  scale: image.scale,
                                  child: DottedBorder(
                                    padding: EdgeInsets.zero,
                                    color: zoom.selectedIndex ==
                                            zoom.images.indexOf(image)
                                        ? Colors.black
                                        : Colors.white,
                                    strokeWidth: zoom.selectedIndex ==
                                            zoom.images.indexOf(image)
                                        ? 1
                                        : 0,
                                    child: Container(
                                      color: zoom.selectedIndex ==
                                              zoom.images.indexOf(image)
                                          ? const Color.fromARGB(
                                              255, 195, 194, 194)
                                          : Colors.white,
                                      child: InteractiveViewer(
                                        maxScale: 5,
                                        scaleEnabled: zoom.selectedIndex ==
                                            zoom.images.indexOf(image),
                                        panEnabled: true,
                                        onInteractionUpdate: (details) {
                                          {
                                            zoom.onInteraction(details, image);
                                          }
                                        },
                                        onInteractionEnd: (details) {},
                                        child: Image.network(
                                          Provider.of<CartProvider>(context)
                                              .cartProduct[
                                                  zoom.images.indexOf(image)]
                                              .imageUrl, // Replace with actual image URL
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:pinetech/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartCanvasScreen extends StatefulWidget {
  @override
  _CartCanvasScreenState createState() => _CartCanvasScreenState();
}

class _CartCanvasScreenState extends State<CartCanvasScreen> {
  int? _selectedIndex;
  bool? isLongPressAndMove;
  List<MyImage> images = [
    MyImage(isSelected: false, position: Offset(10, 10), scale: 1),
    MyImage(isSelected: false, position: Offset(10, 120), scale: 1),
    MyImage(isSelected: false, position: Offset(120, 10), scale: 1),
    MyImage(isSelected: false, position: Offset(120, 120), scale: 1),
    MyImage(isSelected: false, position: Offset(10, 240), scale: 1),
    MyImage(isSelected: false, position: Offset(120, 240), scale: 1),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images = images.sublist(0,
        Provider.of<CartProvider>(context, listen: false).cartProduct.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Container'),
      ),
      body: Container(
        height: 400.0,
        width: 300.0,
        color: Colors.grey[200],
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: images.map((image) {
            return Positioned(
              left: image.position.dx,
              top: image.position.dy,
              child: GestureDetector(
                onScaleStart: (details) {
                  setState(() {
                    isLongPressAndMove = false;
                  });
                },
                onScaleUpdate: (isLongPressAndMove == true)
                    ? null
                    : (details) {
                        // print(details.focalPointDelta);
                        if (_selectedIndex == images.indexOf(image)) {
                          {
                            setState(() {
                              image.position += details.focalPointDelta;
                              print(image.position.dx);
                              print(300 - 100 * image.scale);
                              // Ensure the image stays within bounds
                              image.position = Offset(
                                image.position.dx.clamp(
                                    0.0 + ((100 * image.scale - 100) / 2),
                                    300.0 -
                                        (100 * image.scale -
                                            (100 * image.scale - 100) / 2)),
                                image.position.dy.clamp(
                                    0.0 + ((100 * image.scale - 100) / 2),
                                    400.0 -
                                        (100 * image.scale -
                                            (100 * image.scale - 100) / 2)),
                              );
                            });
                            setState(() {
                              image.scale *= details.scale;
                              // Ensure the scale is within bounds
                              image.scale = image.scale.clamp(1.0, 1.5);
                            });
                          }
                        }
                      },
                child: XGestureDetector(
                  // onPanUpdate: (details) {
                  //   print("panning");
                  //   // Update the position of the selected image
                  //   if (_selectedIndex == images.indexOf(image)) {
                  //     setState(() {
                  //       image.position += details.delta;
                  //       // Ensure the image stays within bounds
                  //       image.position = Offset(
                  //         image.position.dx
                  //             .clamp(0.0, 300.0 - 100.0 * image.scale),
                  //         image.position.dy
                  //             .clamp(0.0, 400.0 - 100.0 * image.scale),
                  //       );
                  //     });
                  //   }
                  // },
                  // onLongPressEnd: () {
                  //   setState(() {
                  //     _selectedIndex = null;
                  //   });
                  // },
                  onLongPressMove: (details) {
                    setState(() {
                      isLongPressAndMove = true;
                    });
                    if (_selectedIndex == images.indexOf(image)) {
                      {
                        setState(() {
                          image.position += details.localDelta;
                          print(image.position.dx);
                          print(300 - 100 * image.scale);
                          // Ensure the image stays within bounds
                          image.position = Offset(
                            image.position.dx.clamp(
                                0.0 + ((100 * image.scale - 100) / 2),
                                300.0 -
                                    (100 * image.scale -
                                        (100 * image.scale - 100) / 2)),
                            image.position.dy.clamp(
                                0.0 + ((100 * image.scale - 100) / 2),
                                400.0 -
                                    (100 * image.scale -
                                        (100 * image.scale - 100) / 2)),
                          );

                          // setState(() {
                          //   image.scale *= details.scale;
                          //   // Ensure the scale is within bounds
                          //   image.scale = image.scale.clamp(1.0, 1.5);
                          // });
                        });
                      }
                    }

                    setState(() {
                      _selectedIndex = images.indexOf(image);
                    });
                    // Toggle selection for the image on double tap
                  },
                  // onLongPressEnd: (details) {
                  //   {
                  //     setState(() {
                  //       image.position = details.localPosition;
                  //       print(image.position.dx);
                  //       print(300 - 100 * image.scale);
                  //       // Ensure the image stays within bounds
                  //       image.position = Offset(
                  //         image.position.dx.clamp(
                  //             0.0 + ((100 * image.scale - 100) / 2),
                  //             300.0 -
                  //                 (100 * image.scale -
                  //                     (100 * image.scale - 100) / 2)),
                  //         image.position.dy.clamp(
                  //             0.0 + ((100 * image.scale - 100) / 2),
                  //             400.0 -
                  //                 (100 * image.scale -
                  //                     (100 * image.scale - 100) / 2)),
                  //       );

                  //       // setState(() {
                  //       //   image.scale *= details.scale;
                  //       //   // Ensure the scale is within bounds
                  //       //   image.scale = image.scale.clamp(1.0, 1.5);
                  //       // });
                  //     });
                  //   }
                  // },
                  onLongPress: (event) {
                    setState(() {
                      _selectedIndex = images.indexOf(image);
                    });
                    // Toggle selection for the image on double tap
                  },
                  child: Transform.scale(
                    scale: image.scale,
                    child: Container(
                      color: _selectedIndex == images.indexOf(image)
                          ? Colors.red
                          : Colors.white,
                      child: Image.network(
                        Provider.of<CartProvider>(context)
                            .cartProduct[images.indexOf(image)]
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
        ),
      ),
    );
  }
}

class MyImage {
  Offset position = Offset(50.0, 50.0);
  double scale = 1.0;
  bool isSelected = false;

  MyImage(
      {required this.position, required this.scale, required this.isSelected});
}

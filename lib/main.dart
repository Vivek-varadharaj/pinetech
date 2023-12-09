import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Container Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyContainer(),
    );
  }
}

class MyContainer extends StatefulWidget {
  @override
  _MyContainerState createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  int? _selectedIndex;
  List<MyImage> images = [
    MyImage(isSelected: false, position: Offset(10, 10), scale: 1),
    MyImage(isSelected: false, position: Offset(100, 50), scale: 1)
  ];

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
                onScaleUpdate: (details) {
                  if (_selectedIndex == images.indexOf(image)) {
                    {
                      print(details.pointerCount);
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

                        setState(() {
                          image.scale *= details.scale;
                          // Ensure the scale is within bounds
                          image.scale = image.scale.clamp(1.0, 1.5);
                        });
                      });
                    }
                  }
                },
                // onPanUpdate: (details) {
                //   print("panning");
                //   // Update the position of the selected image
                //   if (image.isSelected) {
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
                onDoubleTap: () {
                  // Toggle selection for the image on double tap
                  _selectedIndex = images.indexOf(image);
                },
                child: Transform.scale(
                  scale: image.scale,
                  child: Container(
                    color: Colors.red,
                    child: Image.asset(
                      "assets/1.jpg", // Replace with actual image URL
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add a new image to the container
          setState(() {
            images.add(MyImage());
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyImage {
  Offset position = Offset(50.0, 50.0);
  double scale = 1.0;
  bool isSelected = false;

  MyImage({position, scale, isSelected});
}

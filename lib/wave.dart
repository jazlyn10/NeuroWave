import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:neuro/models/predictions.dart';
import 'package:neuro/screens/drawing_painter.dart';
import 'package:neuro/services/recognizer2.dart';
import 'package:neuro/result.dart';

class WaveDrawingScreen extends StatefulWidget {
  @override
  _WaveDrawingScreenState createState() => _WaveDrawingScreenState();
}

class _WaveDrawingScreenState extends State<WaveDrawingScreen> {
  final List<Offset?> points = [];
  final Recognizer _recognizer = Recognizer();
  Prediction? _prediction;
  final GlobalKey _boundaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initModel();
  }

  Future<void> _initModel() async {
    await _recognizer.loadModel();
    print("Model has been loaded successfully!");
  }

  Future<void> _classifyDrawing() async {
    Uint8List imageData = await _getImageData();
    if (imageData.isNotEmpty) {
      var predictions = await _recognizer.recognize(imageData);
      print("Raw predictions data: $predictions");  // Add this to debug
      if (predictions.isNotEmpty) {
        Prediction? prediction = Prediction.fromJson(predictions.first);
        print('Prediction result: ${prediction?.labelDescription}');

        // Navigate to ResultsPage with prediction result and image data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(
              predictionResult: prediction?.labelDescription ?? 'No prediction available',
              confidenceScore: prediction?.confidence ?? 0.0, // Pass confidence score
              imageData: imageData,
            ),
          ),
        );

      } else {
        print('No prediction results returned');
      }
    }
  }

  Future<Uint8List> _getImageData() async {
    // Capture the drawing as an image
    RenderRepaintBoundary boundary =
    _boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image? image;

    try {
      image = await boundary.toImage(pixelRatio: 1.0);
    } catch (e) {
      print('Error capturing image: $e');
      return Uint8List(0);
    }

    // Convert the image to PNG bytes
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      return Uint8List(0);
    }
    Uint8List imageData = byteData.buffer.asUint8List();

    // Resize and compress the image data if necessary
    const desiredSize = 602112; // Target size in bytes
    if (imageData.length > desiredSize) {
      // If image size is larger, compress the image
      // (Replace this part with image compression logic if needed)
      return imageData.sublist(0, desiredSize);
    } else if (imageData.length < desiredSize) {
      // If image size is smaller, pad it with zeros
      Uint8List paddedImageData = Uint8List(desiredSize);
      paddedImageData.setRange(0, imageData.length, imageData);
      return paddedImageData;
    } else {
      // Image size is already correct
      return imageData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(top: 12.0, left: 15.0),
          child: Text(
            'Wave Drawing',
            style: TextStyle(
              color: Color(0xFF242E49),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                points.clear();
                _prediction = null;
              });
            },
            icon: Icon(Icons.undo),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return RepaintBoundary(
              key: _boundaryKey,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'lib/images/wave.png', // Change the image asset to a wave image
                      width: 300,
                      height: 300,
                    ),
                  ),
                  GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        Offset adjustedPosition = details.localPosition;
                        points.add(adjustedPosition);
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        points.add(null);
                      });
                    },
                    child: CustomPaint(
                      painter: DrawingPainter(points),
                      size: Size.infinite,
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: (constraints.maxWidth - 327) / 2,
                    child: SizedBox(
                      height: 56,
                      width: 327,
                      child: ElevatedButton(
                        onPressed: () {
                          _classifyDrawing();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0F67FE), // Button background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: _prediction != null
          ? FloatingActionButton(
        onPressed: () {
          // Handle actions after prediction
        },
        child: Icon(Icons.check),
      )
          : null,
    );
  }
}

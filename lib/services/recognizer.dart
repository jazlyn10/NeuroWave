import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:neuro/utils/constants.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_tflite/flutter_tflite.dart';

final _canvasCullRect = Rect.fromPoints(
  Offset(0, 0),
  Offset(Constants.imageSize, Constants.imageSize),
);

final _whitePaint = Paint()
  ..strokeCap = StrokeCap.round
  ..color = Colors.white
  ..strokeWidth = Constants.strokeWidth;

final _bgPaint = Paint()
  ..color = Colors.black;

class Recognizer {
  Future loadModel() {
    Tflite.close();

    return Tflite.loadModel(
      model: "assets/spiralhopefullyfin.tflite",
      labels: "assets/spiralhopefullyfin.txt",
    );
  }

  dispose() {
    Tflite.close();
  }

  Future<Uint8List> previewImage(List<Offset> points) async {
    final picture = _pointsToPicture(points);
    final image = await picture.toImage(Constants.mnistImageSize.toInt(), Constants.mnistImageSize.toInt()); // Convert double to int
    var pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List(); // Add null-check
  }

  Future recognize(Uint8List imageData) async {
    return _predict(imageData);
  }

  Future _predict(Uint8List bytes) async {
    // Process image to match input requirements of the model
    Uint8List formattedBytes = await processImageForModel(bytes, 224, 224);

    return Tflite.runModelOnBinary(binary: formattedBytes.buffer.asUint8List());
  }


  Future<Uint8List> processImageForModel(Uint8List bytes, int width, int height) async {
    // Decode image, resize it to the expected size, and normalize the pixel values
    img.Image image = img.decodeImage(bytes)!;
    img.Image resized = img.copyResize(image, width: width, height: height);

    // Assuming the model expects pixel values in [0, 1]
    Float32List imageBuffer = Float32List(resized.width * resized.height * 3);
    for (int y = 0; y < resized.height; y++) {
      for (int x = 0; x < resized.width; x++) {
        var pixel = resized.getPixel(x, y);
        imageBuffer[(y * resized.width + x) * 3 + 0] = img.getRed(pixel) / 255.0;
        imageBuffer[(y * resized.width + x) * 3 + 1] = img.getGreen(pixel) / 255.0;
        imageBuffer[(y * resized.width + x) * 3 + 2] = img.getBlue(pixel) / 255.0;
      }
    }

    return imageBuffer.buffer.asUint8List();
  }

  Future<Uint8List> _imageToByteListUint8(Picture pic, int size) async {
    final img = await pic.toImage(size, size);
    final imgBytes = await img.toByteData();
    final resultBytes = Float32List(size * size);
    final buffer = Float32List.view(resultBytes.buffer);

    int index = 0;

    for (int i = 0; i < imgBytes!.lengthInBytes; i += 4) { // Add null-check
      final r = imgBytes.getUint8(i);
      final g = imgBytes.getUint8(i + 1);
      final b = imgBytes.getUint8(i + 2);
      buffer[index++] = (r + g + b) / 3.0 / 255.0;
    }

    return resultBytes.buffer.asUint8List();
  }

  Picture _pointsToPicture(List<Offset> points) {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder, _canvasCullRect)
      ..scale(Constants.mnistImageSize / Constants.canvasSize);

    canvas.drawRect(
        Rect.fromLTWH(0, 0, Constants.imageSize, Constants.imageSize),
        _bgPaint);

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, _whitePaint); // Add null-checks
      }
    }

    return recorder.endRecording();
  }
}
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final String predictionResult;
  final Uint8List imageData;
  final double confidenceScore;

  ResultsPage({required this.predictionResult, required this.imageData, required this.confidenceScore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediction Results'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 23),
              child: Text(
                predictionResult == "PD" ? "Parkinson Detected" : "No Parkinson Detected",
                style: TextStyle(fontSize: 29, color: Color(0xFF242E49), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Confidence Score: ${confidenceScore.toStringAsFixed(2)}', // Display confidence score here
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Disclaimer :\nResults are intended as aids to diagnosis and should be interpreted by qualified healthcare professionals, Recognizing the potential for variations.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20),
/*              child: Text(
                'Captured Image:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),*/
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 20),
              width: 200,
              height: 200,
/*              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),*/
/*              child: Image.memory(
                imageData,
                fit: BoxFit.cover,
              ),*/
            ),
          ],
        ),
      ),
    );
  }
}

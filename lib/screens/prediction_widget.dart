import 'package:flutter/material.dart';
import 'package:neuro/models/predictions.dart';

class PredictionWidget extends StatelessWidget {
  final List<Prediction> predictions;

  const PredictionWidget({
    Key? key,
    this.predictions = const [],
  }) : super(key: key);

  Widget _classWidget(int classLabel, Prediction? prediction) {
    return Column(
      children: <Widget>[
        Text(
          classLabel.toString(),
          style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: prediction == null
                ? Colors.black
                : classLabel == 0
                ? Colors.green // No opacity for confidence, as confidence is removed
                : Colors.red, // No opacity for confidence, as confidence is removed
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Assume predictions only contain one element for binary classification
    final prediction = predictions.isNotEmpty ? predictions.first : null;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _classWidget(0, prediction),
            _classWidget(1, prediction),
          ],
        ),
      ],
    );
  }
}

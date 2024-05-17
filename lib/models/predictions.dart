class Prediction {
  final int label;
  final double confidence; // Add confidence property

  Prediction({required this.label, required this.confidence});

  factory Prediction.fromJson(Map<dynamic, dynamic> json) {
    // Ensure that the label is parsed correctly from the prediction data
    int parsedLabel = int.tryParse(json['label'].split(" ")[0]) ?? 0;
    double parsedConfidence = double.tryParse(json['confidence'].toString()) ?? 0.0;

    return Prediction(
      label: parsedLabel,
      confidence: parsedConfidence,
    );
  }

  String get labelDescription {
    return label == 1 ? 'PD' : 'non-PD';
  }
}

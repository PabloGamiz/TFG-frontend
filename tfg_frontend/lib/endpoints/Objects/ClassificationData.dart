class ClassificationData {
  final int number_metrics;
  final String calification;
  final double min_C1;
  final double max_C1;
  final double min_C2;
  final double max_C2;

  const ClassificationData({
    required this.number_metrics,
    required this.calification,
    required this.min_C1,
    required this.max_C1,
    required this.min_C2,
    required this.max_C2,
  });

  factory ClassificationData.fromJson(Map<String, dynamic> json) {
    return ClassificationData(
      number_metrics: json['number_metrics'],
      calification: json['calification'],
      min_C1: json['min_C1'],
      max_C1: json['max_C1'],
      min_C2: json['min_C2'],
      max_C2: json['max_C2'],
    );
  }
}

import 'dart:ffi';

class NonResidentialBuildingClassification {
  final String calification;
  final Float min_C;
  final Float max_C;

  const NonResidentialBuildingClassification({
    required this.calification,
    required this.min_C,
    required this.max_C,
  });

  factory NonResidentialBuildingClassification.fromJson(
      Map<String, dynamic> json) {
    return NonResidentialBuildingClassification(
      calification: json['calification'],
      min_C: json['min_C'],
      max_C: json['max_C'],
    );
  }
}

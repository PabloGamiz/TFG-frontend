import 'dart:ffi';

class ResidentialBuildingClassification {
  final String calification;
  final Float min_C1;
  final Float max_C1;
  final Float min_C2;
  final Float max_C2;

  const ResidentialBuildingClassification({
    required this.calification,
    required this.min_C1,
    required this.max_C1,
    required this.min_C2,
    required this.max_C2,
  });

  factory ResidentialBuildingClassification.fromJson(
      Map<String, dynamic> json) {
    return ResidentialBuildingClassification(
      calification: json['calification'],
      min_C1: json['min_C1'],
      max_C1: json['max_C1'],
      min_C2: json['min_C2'],
      max_C2: json['max_C2'],
    );
  }
}

class PersonalInformationModel {
  final String name;
  final String dayOfBirth;
  final List<String> likingDistrictIds;
  final String livingDistrictId;
  final int myMonthlySalary;
  final int familyMemberMonthlySalary;
  final int allFamilyMemberCount;
  final String position;
  final bool hasCar;
  final int carPrice;
  final int assetPrice;

  PersonalInformationModel({
    required this.name,
    required this.dayOfBirth,
    required this.likingDistrictIds,
    required this.livingDistrictId,
    required this.myMonthlySalary,
    required this.familyMemberMonthlySalary,
    required this.allFamilyMemberCount,
    required this.position,
    required this.hasCar,
    required this.carPrice,
    required this.assetPrice,
  });

  factory PersonalInformationModel.fromJson(Map<String, dynamic> json) {
    return PersonalInformationModel(
      name: json['name'] ?? '',
      dayOfBirth: json['dayOfBirth'] ?? '',
      likingDistrictIds: List<String>.from(json['likingDistrictIds'] ?? []),
      livingDistrictId: json['livingDistrictId'] ?? '',
      myMonthlySalary: json['myMonthlySalary'] ?? 0,
      familyMemberMonthlySalary: json['familyMemberMonthlySalary'] ?? 0,
      allFamilyMemberCount: json['allFamilyMemberCount'] ?? 0,
      position: json['position'] ?? '',
      hasCar: json['hasCar'] ?? false,
      carPrice: json['carPrice'] ?? 0,
      assetPrice: json['assetPrice'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dayOfBirth': dayOfBirth,
      'likingDistrictIds': likingDistrictIds,
      'livingDistrictId': livingDistrictId,
      'myMonthlySalary': myMonthlySalary,
      'familyMemberMonthlySalary': familyMemberMonthlySalary,
      'allFamilyMemberCount': allFamilyMemberCount,
      'position': position,
      'hasCar': hasCar,
      'carPrice': carPrice,
      'assetPrice': assetPrice,
    };
  }
} 
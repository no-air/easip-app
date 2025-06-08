// lib/app/modules/survey/model/signup_request.dart

class SignupRequest {
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

  const SignupRequest({
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

  factory SignupRequest.fromJson(Map<String, dynamic> json) => SignupRequest(
    name: json['name'] as String,
    dayOfBirth: json['dayOfBirth'] as String,
    likingDistrictIds:
        (json['likingDistrictIds'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
    livingDistrictId: json['livingDistrictId'] as String,
    myMonthlySalary: json['myMonthlySalary'] as int,
    familyMemberMonthlySalary: json['familyMemberMonthlySalary'] as int,
    allFamilyMemberCount: json['allFamilyMemberCount'] as int,
    position: json['position'] as String,
    hasCar: json['hasCar'] as bool,
    carPrice: json['carPrice'] as int,
    assetPrice: json['assetPrice'] as int,
  );

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);

  Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
      <String, dynamic>{
        'name': instance.name,
        'dayOfBirth': instance.dayOfBirth,
        'likingDistrictIds': instance.likingDistrictIds,
        'livingDistrictId': instance.livingDistrictId,
        'myMonthlySalary': instance.myMonthlySalary,
        'familyMemberMonthlySalary': instance.familyMemberMonthlySalary,
        'allFamilyMemberCount': instance.allFamilyMemberCount,
        'position': instance.position,
        'hasCar': instance.hasCar,
        'carPrice': instance.carPrice,
        'assetPrice': instance.assetPrice,
      };
}

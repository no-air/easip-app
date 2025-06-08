class UserProfileResponse {
  final String name;
  final int likingPostCount;
  final DateTime dayOfBirth;
  final List<String> likingDistrictIds;
  final String livingDistrictId;
  final int myMonthlySalary;
  final int familyMemberMonthlySalary;
  final int allFamilyMemberCount;
  final UserPosition position;
  final bool hasCar;
  final int carPrice;
  final int assetPrice;

  UserProfileResponse({
    required this.name,
    required this.likingPostCount,
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

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      name: json['name'] ?? '',
      likingPostCount: json['likingPostCount'] ?? 0,
      dayOfBirth: DateTime.parse(json['dayOfBirth']),
      likingDistrictIds: List<String>.from(json['likingDistrictIds'] ?? []),
      livingDistrictId: json['livingDistrictId'] ?? '',
      myMonthlySalary: json['myMonthlySalary'] ?? 0,
      familyMemberMonthlySalary: json['familyMemberMonthlySalary'] ?? 0,
      allFamilyMemberCount: json['allFamilyMemberCount'] ?? 1,
      position: UserPosition.fromCode(json['position'] ?? 'GENERAL'),
      hasCar: json['hasCar'] ?? false,
      carPrice: json['carPrice'] ?? 0,
      assetPrice: json['assetPrice'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'likingPostCount': likingPostCount,
      'dayOfBirth': dayOfBirth.toIso8601String().split('T')[0], 
      'likingDistrictIds': likingDistrictIds,
      'livingDistrictId': livingDistrictId,
      'myMonthlySalary': myMonthlySalary,
      'familyMemberMonthlySalary': familyMemberMonthlySalary,
      'allFamilyMemberCount': allFamilyMemberCount,
      'position': position.code,
      'hasCar': hasCar,
      'carPrice': carPrice,
      'assetPrice': assetPrice,
    };
  }

  // 생년월일 포맷팅
  String get formattedBirthDate {
    return '${dayOfBirth.year}. ${dayOfBirth.month}. ${dayOfBirth.day}';
  }

  // 관심 지역 텍스트
  String get likingDistrictsText {
    if (likingDistrictIds.isEmpty) return '설정된 관심 지역이 없습니다';
    return likingDistrictIds.join(', ');
  }

  // copyWith 메서드
  UserProfileResponse copyWith({
    String? name,
    int? likingPostCount,
    DateTime? dayOfBirth,
    List<String>? likingDistrictIds,
    String? livingDistrictId,
    int? myMonthlySalary,
    int? familyMemberMonthlySalary,
    int? allFamilyMemberCount,
    UserPosition? position,
    bool? hasCar,
    int? carPrice,
    int? assetPrice,
  }) {
    return UserProfileResponse(
      name: name ?? this.name,
      likingPostCount: likingPostCount ?? this.likingPostCount,
      dayOfBirth: dayOfBirth ?? this.dayOfBirth,
      likingDistrictIds: likingDistrictIds ?? this.likingDistrictIds,
      livingDistrictId: livingDistrictId ?? this.livingDistrictId,
      myMonthlySalary: myMonthlySalary ?? this.myMonthlySalary,
      familyMemberMonthlySalary: familyMemberMonthlySalary ?? this.familyMemberMonthlySalary,
      allFamilyMemberCount: allFamilyMemberCount ?? this.allFamilyMemberCount,
      position: position ?? this.position,
      hasCar: hasCar ?? this.hasCar,
      carPrice: carPrice ?? this.carPrice,
      assetPrice: assetPrice ?? this.assetPrice,
    );
  }
}


enum UserPosition {
  youngMan('YOUNG_MAN', '청년'),
  newlywed('NEWLY_MARRIED_COUPLE', '신혼부부');
  
  const UserPosition(this.code, this.displayName);
  
  final String code;
  final String displayName;

  static UserPosition fromCode(String code) {
    return UserPosition.values.firstWhere(
      (position) => position.code == code,
      orElse: () => UserPosition.youngMan,
    );
  }
}
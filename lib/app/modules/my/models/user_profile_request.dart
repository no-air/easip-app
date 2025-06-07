import 'package:easip_app/app/modules/my/models/user_profile_response.dart';

class UserProfileRequest {
  final String name;
  final String dayOfBirth; // YYYY-MM-DD 형식
  final List<String> likingDistrictIds;
  final String livingDistrictId;
  final int myMonthlySalary;
  final int familyMemberMonthlySalary;
  final int allFamilyMemberCount;
  final String position; // enum의 code 값
  final bool hasCar;
  final int carPrice;
  final int assetPrice;

  UserProfileRequest({
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

  // DateTime에서 생성하는 생성자
  UserProfileRequest.fromDateTime({
    required this.name,
    required DateTime dayOfBirthDateTime,
    required this.likingDistrictIds,
    required this.livingDistrictId,
    required this.myMonthlySalary,
    required this.familyMemberMonthlySalary,
    required this.allFamilyMemberCount,
    required UserPosition positionEnum,
    required this.hasCar,
    required this.carPrice,
    required this.assetPrice,
  }) : dayOfBirth = dayOfBirthDateTime.toIso8601String().split('T')[0],
       position = positionEnum.code;

  // 기존 UserProfile에서 변환하는 생성자 (만약 기존 DTO가 있다면)
  UserProfileRequest.fromUserProfile(UserProfileResponse userProfile)
    : name = userProfile.name,
      dayOfBirth = userProfile.dayOfBirth.toIso8601String().split('T')[0],
      likingDistrictIds = userProfile.likingDistrictIds,
      livingDistrictId = userProfile.livingDistrictId,
      myMonthlySalary = userProfile.myMonthlySalary,
      familyMemberMonthlySalary = userProfile.familyMemberMonthlySalary,
      allFamilyMemberCount = userProfile.allFamilyMemberCount,
      position = userProfile.position.code,
      hasCar = userProfile.hasCar,
      carPrice = userProfile.carPrice,
      assetPrice = userProfile.assetPrice;

  // JSON 변환 (서버로 전송용)
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

  // JSON에서 생성 (서버 응답에서 파싱용, 필요시)
  factory UserProfileRequest.fromJson(Map<String, dynamic> json) {
    return UserProfileRequest(
      name: json['name'] ?? '',
      dayOfBirth: json['dayOfBirth'] ?? '',
      likingDistrictIds: List<String>.from(json['likingDistrictIds'] ?? []),
      livingDistrictId: json['livingDistrictId'] ?? '',
      myMonthlySalary: json['myMonthlySalary'] ?? 0,
      familyMemberMonthlySalary: json['familyMemberMonthlySalary'] ?? 0,
      allFamilyMemberCount: json['allFamilyMemberCount'] ?? 1,
      position: json['position'] ?? 'GENERAL',
      hasCar: json['hasCar'] ?? false,
      carPrice: json['carPrice'] ?? 0,
      assetPrice: json['assetPrice'] ?? 0,
    );
  }

  // 유효성 검사
  bool isValid() {
    if (name.trim().isEmpty) return false;
    if (dayOfBirth.isEmpty) return false;
    if (livingDistrictId.isEmpty) return false;
    if (myMonthlySalary < 0) return false;
    if (familyMemberMonthlySalary < 0) return false;
    if (allFamilyMemberCount <= 0) return false;
    if (carPrice < 0) return false;
    if (assetPrice < 0) return false;
    
    // 날짜 형식 검사 (YYYY-MM-DD)
    try {
      DateTime.parse(dayOfBirth);
    } catch (e) {
      return false;
    }
    
    return true;
  }

  // 유효성 검사 에러 메시지
  List<String> getValidationErrors() {
    List<String> errors = [];
    
    if (name.trim().isEmpty) {
      errors.add('이름을 입력해주세요.');
    }
    
    if (dayOfBirth.isEmpty) {
      errors.add('생년월일을 입력해주세요.');
    } else {
      // YYYY-MM-DD 형식 검사
      final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
      final isFormatValid = dateRegex.hasMatch(dayOfBirth);
      
      if (!isFormatValid) {
        errors.add('생년월일은 YYYY-MM-DD 형식으로 입력해주세요.');
        return errors;
      }

      // 유효한 날짜인지 검사
      try {
        final dateParts = dayOfBirth.split('-');
        final year = int.parse(dateParts[0]);
        final month = int.parse(dateParts[1]);
        final day = int.parse(dateParts[2]);
        
        if (year < 1900 || year > 2100) {
          errors.add('연도는 1900년부터 2100년 사이여야 합니다.');
        }
        if (month < 1 || month > 12) {
          errors.add('월은 1부터 12 사이여야 합니다.');
        }
        if (day < 1 || day > 31) {
          errors.add('일은 1부터 31 사이여야 합니다.');
        }
        
        // 실제 존재하는 날짜인지 검사
        DateTime(year, month, day);
        
      } catch (e) {
        errors.add('유효하지 않은 날짜입니다.');
      }
    }
    
    if (livingDistrictId.isEmpty) {
      errors.add('거주 지역을 선택해주세요.');
    }
    
    if (myMonthlySalary < 0) {
      errors.add('본인 월급은 0 이상이어야 합니다.');
    }
    
    if (familyMemberMonthlySalary < 0) {
      errors.add('가족 월급은 0 이상이어야 합니다.');
    }
    
    if (allFamilyMemberCount <= 0) {
      errors.add('가족 구성원 수는 1명 이상이어야 합니다.');
    }
    
    if (carPrice < 0) {
      errors.add('차량 가격은 0 이상이어야 합니다.');
    }
    
    if (assetPrice < 0) {
      errors.add('자산 가격은 0 이상이어야 합니다.');
    }
    
    return errors;
  }

  // copyWith 메서드
  UserProfileRequest copyWith({
    String? name,
    String? dayOfBirth,
    List<String>? likingDistrictIds,
    String? livingDistrictId,
    int? myMonthlySalary,
    int? familyMemberMonthlySalary,
    int? allFamilyMemberCount,
    String? position,
    bool? hasCar,
    int? carPrice,
    int? assetPrice,
  }) {
    return UserProfileRequest(
      name: name ?? this.name,
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

  @override
  String toString() {
    return 'UserProfileRequest(name: $name, dayOfBirth: $dayOfBirth, position: $position)';
  }
}
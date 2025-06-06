class AnnouncementResponse {
  final int currentPage;
  final int totalPage;
  final int itemPerPage;
  final bool hasNext;
  final List<Announcement> results;

  AnnouncementResponse({
    required this.currentPage,
    required this.totalPage,
    required this.itemPerPage,
    required this.hasNext,
    required this.results,
  });

  factory AnnouncementResponse.fromJson(Map<String, dynamic> json) {
    return AnnouncementResponse(
      currentPage: json['currentPage'] ?? 1,
      totalPage: json['totalPage'] ?? 1,
      itemPerPage: json['itemPerPage'] ?? 10,
      hasNext: json['hasNext'] ?? false,
      results: (json['results'] as List<dynamic>?)
          ?.map((item) => Announcement.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPage': totalPage,
      'itemPerPage': itemPerPage,
      'hasNext': hasNext,
      'results': results.map((item) => item.toJson()).toList(),
    };
  }
}

// 개별 공고 클래스
class Announcement {
  final String postId;
  final String thumbnailUrl;
  final String title;
  final String subscriptionState;
  final DateTime applicationStart;
  final DateTime applicationEnd;
  final int numberOfUnitsRecruiting;
  final bool isPushAlarmRegistered; 

  Announcement({
    required this.postId,
    required this.thumbnailUrl,
    required this.title,
    required this.subscriptionState,
    required this.applicationStart,
    required this.applicationEnd,
    required this.numberOfUnitsRecruiting,
    required this.isPushAlarmRegistered
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      postId: json['postId'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      title: json['title'] ?? '',
      subscriptionState: json['subscriptionState'] ?? '',
      applicationStart: DateTime.parse(json['applicationStart']),
      applicationEnd: DateTime.parse(json['applicationEnd']),
      numberOfUnitsRecruiting: json['numberOfUnitsRecruiting'] ?? 0,
      isPushAlarmRegistered: json['isPushAlarmRegistered'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'thumbnailUrl': thumbnailUrl,
      'title': title,
      'subscriptionState': subscriptionState,
      'applicationStart': applicationStart.toIso8601String(),
      'applicationEnd': applicationEnd.toIso8601String(),
      'numberOfUnitsRecruiting': numberOfUnitsRecruiting,
      'isPushAlarmRegistered': isPushAlarmRegistered,
    };
  }

  // 헬퍼 getter들
  String get periodText {
    final startDate = "${applicationStart.year}.${applicationStart.month.toString().padLeft(2, '0')}.${applicationStart.day.toString().padLeft(2, '0')}";
    final endDate = "${applicationEnd.year}.${applicationEnd.month.toString().padLeft(2, '0')}.${applicationEnd.day.toString().padLeft(2, '0')}";
    return "접수일 $startDate ~ $endDate";
  }

  String get recruitingText => "모집호수 $numberOfUnitsRecruiting";

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(applicationStart) && now.isBefore(applicationEnd);
  }

  // 이미지 URL이 있는지 확인
  bool get hasImage => thumbnailUrl.isNotEmpty;
  
  // 청약 상태에 따른 색상
  // Color get statusColor {
  //   switch (subscriptionState) {
  //     case "청약중":
  //       return Colors.blue;
  //     case "청약예정":
  //       return Colors.orange;
  //     case "청약마감":
  //       return Colors.grey;
  //     default:
  //       return Colors.grey;
  //   }
  // }
}
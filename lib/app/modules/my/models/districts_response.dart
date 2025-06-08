class DistrictResponse {
  final List<District> results;

  DistrictResponse({required this.results});

  factory DistrictResponse.fromJson(Map<String, dynamic> json) {
    return DistrictResponse(
      results:
          (json['results'] as List<dynamic>?)
              ?.map((item) => District.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {'results': results.map((item) => item.toJson()).toList()};
  }

  bool get isEmpty => results.isEmpty;
  int get length => results.length;
  District? findById(String id) => results.where((d) => d.id == id).firstOrNull;
  District? findByName(String name) =>
      results.where((d) => d.name == name).firstOrNull;
  List<String> get names => results.map((d) => d.name).toList();
  List<String> get ids => results.map((d) => d.id).toList();

  // 지역 검색
  List<District> searchDistricts(String query) {
    if (query.isEmpty) return results;
    return results.where((district) => district.name.contains(query)).toList();
  }

  // 선택된 지역들의 이름 가져오기
  List<String> getDistrictNames(List<String> ids) {
    return results
        .where((district) => ids.contains(district.id))
        .map((district) => district.name)
        .toList();
  }

  // ID로 지역 이름 찾기
  String getDistrictName(String id) {
    final district = results.firstWhere(
      (d) => d.id == id,
      orElse: () => District(id: '', name: ''),
    );
    return district.id.isEmpty ? '알 수 없는 지역' : district.name;
  }
}

// 개별 지역 클래스
class District {
  final String id;
  final String name;

  District({required this.id, required this.name});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(id: json['id'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is District && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'District(id: $id, name: $name)';
}

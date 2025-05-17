class TestModel {
    final int id;
    final String title;
    final String body;
    final int userId;

    const TestModel({
        required this.id,
        required this.title,
        required this.body,
        required this.userId,
    });

    factory TestModel.fromJson(Map<String, dynamic> json) {
        return TestModel(
            id: json['id'] as int,
            title: json['title'] as String,
            body: json['body'] as String,
            userId: (json['userId'] as num).toInt(),
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'id': id,
            'title': title,
            'body': body,
            'userId': userId,
        };
    }

    @override
    String toString() => 'TestModel(id: $id, title: $title, body: $body, userId: $userId)';
}

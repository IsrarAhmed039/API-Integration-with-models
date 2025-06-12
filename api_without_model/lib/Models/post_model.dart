class TaskModel {
  final String id;
  final String name;
  final String body;

  TaskModel({required this.id, required this.name, required this.body});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'body': body,
    };
  }
}

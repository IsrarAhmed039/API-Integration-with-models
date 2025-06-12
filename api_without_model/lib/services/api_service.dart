import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_without_model/Models/post_model.dart';

// Base URL (without ID)
const String baseUrl = "https://crudcrud.com/api/5c1f06aa26d54462bee3e3005c63d4b7/tasks";

// -----------------------------
// GET: Fetch all tasks
// -----------------------------
Future<List<TaskModel>> getPostApi() async {
  try {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body);
      return responseBody.map((item) => TaskModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print("Error: $e");
    throw Exception('Error fetching data: $e');
  }
}

// -----------------------------
// POST: Create new task
// -----------------------------
Future<void> postTaskApi(TaskModel task) async {
  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create task: ${response.statusCode}');
    }
  } catch (e) {
    print("Error posting data: $e");
    throw Exception('Error posting data: $e');
  }
}

// -----------------------------
// PUT: Update task by ID
// -----------------------------
Future<void> updateTaskApi(String id, TaskModel updatedTask) async {
  final updateUrl = "$baseUrl/$id";

  try {
    final response = await http.put(
      Uri.parse(updateUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedTask.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task: ${response.statusCode}');
    }
  } catch (e) {
    print("Error updating data: $e");
    throw Exception('Error updating data: $e');
  }
}

Future<void> deleteTaskApi(String id, TaskModel deletedTask) async {
  final updateUrl = "$baseUrl/$id";

  try {
    final response = await http.delete(
      Uri.parse(updateUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(deletedTask.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task: ${response.statusCode}');
    }
  } catch (e) {
    print("Error Deleting data: $e");
    throw Exception('Error Deleting data: $e');
  }
}

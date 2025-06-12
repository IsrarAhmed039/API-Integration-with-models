import 'package:api_without_model/Models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:api_without_model/services/api_service.dart' as api_service;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Data")),
      body: FutureBuilder<List<TaskModel>>(
        future: api_service.getPostApi(),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final task = data[index];
                return ListTile(
                  title: Text(task.name.isEmpty ? "No Name" : task.name),
                  subtitle: Text(task.body.isEmpty ? "No Body" : task.body),
                  trailing: IconButton(
                    icon: Icon(Icons.update),
                    onPressed: () async {
                      TaskModel updatedTask = TaskModel(
                        id: task.id,
                        name: "Updated ${task.name}",
                        body: "Updated ${task.body}",
                      );

                      await api_service.updateTaskApi(task.id, updatedTask);
                      setState(() {});
                    },
                  ),
                  leading: IconButton(onPressed: ()async{
                    TaskModel deletedTask=TaskModel(id: task.id, 
                    name: "Updated ${task.name}", body: "Updated ${task.body}",
                    );
                    await api_service.deleteTaskApi(task.id, deletedTask);
                    setState(() {
                      
                    });
                  }, icon: Icon(Icons.delete)),
                );
              },
            );
          }

          return Center(child: Text('No data available'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          TaskModel newTask = TaskModel(
            id: '',
            name: 'Javed',
            body: 'Flutter Developer',
          );

          await api_service.postTaskApi(newTask);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

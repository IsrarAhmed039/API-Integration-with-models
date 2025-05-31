import 'dart:convert';

import 'package:api_without_model/Models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<PostModel> postData = [];

  Future<List<PostModel>> getPostApi() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    for (var eachMap in responseBody) {
      postData.add(PostModel.fromJson(eachMap));
    }
    return postData;
  }

  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: FutureBuilder(
        future: getPostApi(),
         builder: (context, snapshot){
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length??0,
              itemBuilder: (context, index){
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(snapshot.data![index].userId.toString()),
                  ),
                  title: Text(snapshot.data![index].title.toString()),
                  subtitle: Text(snapshot.data![index].body.toString()),
                );

              }
            );
       }
       else {
        return Center(
          child: CircularProgressIndicator(),
        );
       }
      }
     )
    );
  }
}

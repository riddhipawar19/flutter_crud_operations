import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_project/data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddNewCourse extends StatelessWidget {
  const AddNewCourse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController course_name = TextEditingController();
    Future<Data> saveData(String course_name) async {
      String uri = "http://192.168.43.27:5000/admin/add_courses";
      final response = await http.post(Uri.parse(uri),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"name": course_name}));
      return dataFromJson(response.body);
    }

    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          child: TextField(
            controller: course_name,
            decoration: InputDecoration(
                hintText: "Enter course name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 20),
            width: 100,
            height: 60,
            child: ElevatedButton(
                onPressed: () {
                  saveData(course_name.text);
                  course_name.text = " ";
                },
                child: Text("Add")))
      ],
    ));
  }
}

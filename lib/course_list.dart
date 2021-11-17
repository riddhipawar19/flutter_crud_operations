import 'dart:convert';
import 'package:demo_project/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  Future<List<Model>> getUserData() async {
    var response = await http
        .get(Uri.parse("http://192.168.43.27:5000/admin/get_courses"));
    var jsonData = json.decode(response.body);

    List<Model> users = [];

    for (var user in jsonData) {
      Model d = Model(user["name"]);
      users.add(d);
    }

    print(users.length);
    return users;
  }

  Future<Data> deleteCourse(String name) async {
      String uri = "http://192.168.43.27:5000/admin/delete_course";
      final response = await http.delete(Uri.parse(uri),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"name": name}));
      setState(() {});
      return dataFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: Card(
                child: FutureBuilder<List<Model>>(
                    future: getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Text("Loading", style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500)));
                      }
                      else if (snapshot.data!.length == 0) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Text("No Courses", style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500)));
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                child: ListTile(
                                    tileColor: Colors.grey[200],
                                    // trailing: InkWell(
                                    //     onTap: () {
                                    //       print("tapped");
                                    //       deleteCourse(
                                    //           snapshot.data![index].name);
                                    //     },
                                    //     child: Icon(Icons.delete,
                                    //         color: Colors.red)),
                                    title: Row(
                                      children: [
                                        Text(snapshot.data![index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700)),
                                                Spacer(),
                                                Icon(Icons.edit,
                                            color: Colors.yellow[700]),
                                            SizedBox(width: 20),
                                            Icon(Icons.delete,
                                            color: Colors.red)
                                      ],
                                    )),
                              );
                            });
                      }
                    }))));
  }
}

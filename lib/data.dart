import 'dart:convert';

class Model {
  final String name;
  Model(this.name);
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
    String name;
    Data({
      this.name: "abc"});
    
    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
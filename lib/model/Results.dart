import 'dart:convert';

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));
String resultsToJson(Results data) => json.encode(data.toJson());
class Results {
  Results({
      this.id, 
      this.name, 
      this.gender, 
      this.species, 
      this.status, 
      this.image,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    species = json['species'];
    status = json['status'];
    image = json['image'];
  }
  String? id;
  String? name;
  String? gender;
  String? species;
  String? status;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['gender'] = gender;
    map['species'] = species;
    map['status'] = status;
    map['image'] = image;
    return map;
  }

}
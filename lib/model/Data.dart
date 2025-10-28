import 'Characters.dart';
import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.characters,});

  Data.fromJson(dynamic json) {
    characters = json['characters'] != null ? Characters.fromJson(json['characters']) : null;
  }
  Characters? characters;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (characters != null) {
      map['characters'] = characters?.toJson();
    }
    return map;
  }

}
// To parse this JSON data, do
//
//     final charactersModel = charactersModelFromJson(jsonString);

import 'dart:convert';

CharactersModel charactersModelFromJson(String str) => CharactersModel.fromJson(json.decode(str));

String charactersModelToJson(CharactersModel data) => json.encode(data.toJson());

class CharactersModel {
  Characters? characters;

  CharactersModel({
    this.characters,
  });

  factory CharactersModel.fromJson(Map<String, dynamic> json) => CharactersModel(
    characters: json["characters"] == null ? null : Characters.fromJson(json["characters"]),
  );

  Map<String, dynamic> toJson() => {
    "characters": characters?.toJson(),
  };
}

class Characters {
  List<Result>? results;

  Characters({
    this.results,
  });

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  String? id;
  String? name;
  String? gender;
  String? status;
  String? image;

  Result({
    this.id,
    this.name,
    this.gender,
    this.status,
    this.image,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    gender: json["gender"],
    status: json["status"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gender": gender,
    "status": status,
    "image": image,
  };
}

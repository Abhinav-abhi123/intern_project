class CharacterDetailModel {
  Character? character;

  CharacterDetailModel({this.character});

  factory CharacterDetailModel.fromJson(Map<String, dynamic> json) {
    return CharacterDetailModel(
      character: json['character'] != null
          ? Character.fromJson(json['character'])
          : null,
    );
  }
}

class Character {
  String? id;
  String? name;
  String? image;
  String? gender;
  String? status;
  String? species;
  Origin? origin;
  List<Episode>? episode;

  Character({
    this.id,
    this.name,
    this.image,
    this.gender,
    this.status,
    this.species,
    this.origin,
    this.episode,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      gender: json['gender'],
      status: json['status'],
      species: json['species'],
      origin:
      json['origin'] != null ? Origin.fromJson(json['origin']) : null,
      episode: json['episode'] != null
          ? (json['episode'] as List)
          .map((e) => Episode.fromJson(e))
          .toList()
          : [],
    );
  }
}

class Origin {
  String? name;

  Origin({this.name});

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      name: json['name'],
    );
  }
}

class Episode {
  String? id;
  String? name;
  String? airDate;
  String? typename;
  List<Character>? characters;

  Episode({
    this.id,
    this.name,
    this.airDate,
    this.typename,
    this.characters,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      typename: json['__typename'],
      characters: json['characters'] != null
          ? (json['characters'] as List)
          .map((c) => Character.fromJson(c))
          .toList()
          : [],
    );
  }
}

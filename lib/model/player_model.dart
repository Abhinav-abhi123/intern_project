class Player {
  int? id;
  final String name;
  final String email;
  final String phone;
  final String date;
  final String state;
  final String zip;
  final bool isSaved;
  final String createdAt;
  final String updatedAt;

  Player({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.date,
    required this.state,
    required this.zip,
    this.isSaved = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Player copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? date,
    String? state,
    String? zip,
    bool? isSaved,
    String? createdAt,
    String? updatedAt,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      date: date ?? this.date,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      isSaved: isSaved ?? this.isSaved,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'date': date,
      'state': state,
      'zip': zip,
      'isSaved': isSaved ? 1 : 0,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      date: map['date'],
      state: map['state'],
      zip: map['zip'],
      isSaved: map['isSaved'] == 1,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }
}

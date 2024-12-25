class Tag{
  String id;
  String name;

  Tag(this.id, this.name);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      json['id'] as String,
      json['name'] as String,
    );
  }
}
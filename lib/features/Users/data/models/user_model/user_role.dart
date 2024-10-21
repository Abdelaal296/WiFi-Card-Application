class UserRole {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserRole({this.id, this.name, this.createdAt, this.updatedAt});

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        id: json['id'] as int?,
        name: json['name'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

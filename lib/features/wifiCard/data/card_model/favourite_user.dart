class FavouriteUser {
  int? id;
  int? networkId;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  FavouriteUser({
    this.id,
    this.networkId,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory FavouriteUser.fromJson(Map<String, dynamic> json) => FavouriteUser(
        id: json['id'] as int?,
        networkId: json['network_id'] as int?,
        userId: json['user_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'network_id': networkId,
        'user_id': userId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

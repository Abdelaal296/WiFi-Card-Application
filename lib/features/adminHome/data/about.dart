class About {
  int? id;
  String? title;
  String? desc;
  DateTime? createdAt;
  DateTime? updatedAt;

  About({this.id, this.title, this.desc, this.createdAt, this.updatedAt});

  factory About.fromJson(Map<String, dynamic> json) => About(
        id: json['id'] as int?,
        title: json['title'] as String?,
        desc: json['desc'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'desc': desc,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

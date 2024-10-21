class NotificationModel {
  int? id;
  String? creatorName;
  int? typeId;
  String? textEn;
  String? textAr;
  String? notificationTypeEn;
  String? notificationTypeAr;
  String? api;
  int? read;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationModel({
    this.id,
    this.creatorName,
    this.typeId,
    this.textEn,
    this.textAr,
    this.notificationTypeEn,
    this.notificationTypeAr,
    this.api,
    this.read,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      creatorName: json['creator_name'] as String?,
      typeId: json['type_id'] as int?,
      textEn: json['text_en'] as String?,
      textAr: json['text_ar'] as String?,
      notificationTypeEn: json['notification_type_en'] as String?,
      notificationTypeAr: json['notification_type_ar'] as String?,
      api: json['api'] as String?,
      read: json['read'] as int?,
      userId: json['user_id'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'creator_name': creatorName,
        'type_id': typeId,
        'text_en': textEn,
        'text_ar': textAr,
        'notification_type_en': notificationTypeEn,
        'notification_type_ar': notificationTypeAr,
        'api': api,
        'read': read,
        'user_id': userId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

class MessageModel {
  late String message;
  late String role_type;
  late String createdAt;
  late bool isRead;

  MessageModel(
      {required this.message,
      required this.role_type,
      required this.createdAt,
      required this.isRead});

  MessageModel.fromJSon(json) {
    message = json['message'];
    role_type = json['role_type'];
    createdAt = json['createdAt'];
    isRead = json['isRead'];
  }
}

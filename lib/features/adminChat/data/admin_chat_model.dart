import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wifi_card/features/chat/data/models/message_model.dart';

class AdminMessageModel {
  int? id;
  String? name;

  AdminMessageModel({this.name, this.id});

  AdminMessageModel.fromJSon(json) {
    name = json['name'] as String?;
    id = json['id'] as int?;
  }
}

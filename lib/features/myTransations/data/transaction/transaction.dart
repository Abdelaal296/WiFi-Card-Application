import 'network_owner.dart';
import 'shop_owner.dart';

class Transaction {
  int? id;
  String? vlaueTransaction;
  String? type;
  int? networkOwnerId;
  int? shopOwnerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  NetworkOwner? networkOwner;
  ShopOwner? shopOwner;

  Transaction({
    this.id,
    this.vlaueTransaction,
    this.type,
    this.networkOwnerId,
    this.shopOwnerId,
    this.createdAt,
    this.updatedAt,
    this.networkOwner,
    this.shopOwner,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['id'] as int?,
        vlaueTransaction: json['vlaue_transaction'] as String?,
        type: json['type'] as String?,
        networkOwnerId: json['network_owner_id'] as int?,
        shopOwnerId: json['shop_owner_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        networkOwner: json['network_owner'] == null
            ? null
            : NetworkOwner.fromJson(
                json['network_owner'] as Map<String, dynamic>),
        shopOwner: json['shop_owner'] == null
            ? null
            : ShopOwner.fromJson(json['shop_owner'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'vlaue_transaction': vlaueTransaction,
        'type': type,
        'network_owner_id': networkOwnerId,
        'shop_owner_id': shopOwnerId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'network_owner': networkOwner?.toJson(),
        'shop_owner': shopOwner?.toJson(),
      };
}

import 'package:wifi_card/features/wifiCard/data/balance_network_model.dart';

import 'favourite_user.dart';

class CardModel {
  int? id;
  String? name;
  int? feeRate;
  num? fees;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  FavouriteUser? favouriteUser;
  BalanceNetworkModel? balance;

  CardModel({
    this.id,
    this.name,
    this.feeRate,
    this.fees,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.favouriteUser,
    this.balance,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        feeRate: json['fee_rate'] as int?,
        fees: json['fees'] as num?,
        userId: json['user_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        favouriteUser: json['favourite_user'] == null
            ? null
            : FavouriteUser.fromJson(
                json['favourite_user'] as Map<String, dynamic>),
        balance: json['balance_network'] == null
            ? null
            : BalanceNetworkModel.fromJson(
                json['balance_network'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'fee_rate': feeRate,
        'fees': fees,
        'user_id': userId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'favourite_user': favouriteUser?.toJson(),
      };
}

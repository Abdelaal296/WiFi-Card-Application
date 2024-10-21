class BalanceNetworkModel {
  int? id;
  int? networkOwnerId;
  int? balance;
  int? shopOwnerId;
  int? networkId;
  DateTime? createdAt;
  DateTime? updatedAt;

  BalanceNetworkModel({
    this.id,
    this.networkOwnerId,
    this.balance,
    this.shopOwnerId,
    this.networkId,
    this.createdAt,
    this.updatedAt,
  });

  factory BalanceNetworkModel.fromJson(Map<String, dynamic> json) {
    return BalanceNetworkModel(
      id: json['id'] as int?,
      networkOwnerId: json['network_owner_id'] as int?,
      balance: json['balance'] as int?,
      shopOwnerId: json['shop_owner_id'] as int?,
      networkId: json['network_id'] as int?,
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
        'network_owner_id': networkOwnerId,
        'balance': balance,
        'shop_owner_id': shopOwnerId,
        'network_id': networkId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

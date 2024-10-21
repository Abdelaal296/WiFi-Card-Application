class ShopOwner {
  int? id;
  String? fullName;
  String? commercialActivity;
  String? phoneNumber;
  String? address;
  String? distributorAccountNumber;
  int? ban;
  String? accountVerifiedAt;
  int? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ShopOwner({
    this.id,
    this.fullName,
    this.commercialActivity,
    this.phoneNumber,
    this.address,
    this.distributorAccountNumber,
    this.ban,
    this.accountVerifiedAt,
    this.roleId,
    this.createdAt,
    this.updatedAt,
  });

  factory ShopOwner.fromJson(Map<String, dynamic> json) => ShopOwner(
        id: json['id'] as int?,
        fullName: json['full_name'] as String?,
        commercialActivity: json['commercial_activity'] as String?,
        phoneNumber: json['phone_number'] as String?,
        address: json['address'] as String?,
        distributorAccountNumber: json['distributor_account_number'] as String?,
        ban: json['ban'] as int?,
        accountVerifiedAt: json['account_verified_at'] as String?,
        roleId: json['role_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'commercial_activity': commercialActivity,
        'phone_number': phoneNumber,
        'address': address,
        'distributor_account_number': distributorAccountNumber,
        'ban': ban,
        'account_verified_at': accountVerifiedAt,
        'role_id': roleId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

import 'user_role.dart';

class AllUserModel {
  int? id;
  String? fullName;
  String? commercialActivity;
  String? phoneNumber;
  String? address;
  String? distributorAccountNumber;
  int? ban;
  int? status;
  int? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserRole? userRole;

  AllUserModel({
    this.id,
    this.fullName,
    this.commercialActivity,
    this.phoneNumber,
    this.address,
    this.distributorAccountNumber,
    this.ban,
    this.roleId,
    this.createdAt,
    this.updatedAt,
    this.userRole,
    this.status,
  });

  factory AllUserModel.fromJson(Map<String, dynamic> json) => AllUserModel(
        id: json['id'] as int?,
        fullName: json['full_name'] as String?,
        commercialActivity: json['commercial_activity'] as String?,
        phoneNumber: json['phone_number'] as String?,
        address: json['address'] as String?,
        distributorAccountNumber: json['distributor_account_number'] as String?,
        ban: json['ban'] as int?,
        status: json['status'] as int?,
        roleId: json['role_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        userRole: json['user_role'] == null
            ? null
            : UserRole.fromJson(json['user_role'] as Map<String, dynamic>),
      );
}

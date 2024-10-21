import 'network_owner.dart';

class Network {
  int? id;
  String? name;
  int? feeRate;
  num? fees;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  NetworkOwner? networkOwner;

  Network({
    this.id,
    this.name,
    this.feeRate,
    this.fees,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.networkOwner,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
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
        networkOwner: json['network_owner'] == null
            ? null
            : NetworkOwner.fromJson(
                json['network_owner'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'fee_rate': feeRate,
        'fees': fees,
        'user_id': userId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'network_owner': networkOwner?.toJson(),
      };
}

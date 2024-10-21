class CardNumberModel {
  int? id;
  int? networkId;
  int? isSold;
  String? cardNumber;

  CardNumberModel({this.id, this.networkId, this.isSold, this.cardNumber});

  factory CardNumberModel.fromJson(Map<String, dynamic> json) {
    return CardNumberModel(
      id: json['id'] as int?,
      networkId: json['network_id'] as int?,
      isSold: json['is_sale'] as int?,
      cardNumber: json['card_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'network_id': networkId,
        'card_number': cardNumber,
      };
}

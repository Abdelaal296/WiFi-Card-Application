class CategoryModel {
  int? id;
  String? category;
  int? price;
  int? shopPriceRate;
  dynamic hours;
  dynamic validity;
  dynamic link;
  int? userId;
  int? networkId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? cardNumbersSaleCount;
  int? cardNumbersNotSaleCount;

  CategoryModel({
    this.id,
    this.category,
    this.price,
    this.shopPriceRate,
    this.hours,
    this.validity,
    this.link,
    this.userId,
    this.networkId,
    this.createdAt,
    this.updatedAt,
    this.cardNumbersSaleCount,
    this.cardNumbersNotSaleCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'] as int?,
        category: json['category'] as String?,
        price: json['price'] as int?,
        shopPriceRate: json['shop_price_rate'] as int?,
        hours: json['hours'] as dynamic,
        validity: json['Validity'] as dynamic,
        link: json['link'] as dynamic,
        userId: json['user_id'] as int?,
        networkId: json['network_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        cardNumbersSaleCount: json['card_numbers_sale_count'] as int?,
        cardNumbersNotSaleCount: json['card_numbers_not_sale_count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        'price': price,
        'shop_price_rate': shopPriceRate,
        'hours': hours,
        'Validity': validity,
        'link': link,
        'user_id': userId,
        'network_id': networkId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}

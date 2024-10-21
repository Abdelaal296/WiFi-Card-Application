class CardTransactionModel {
  int? id;
  String? cardNumber;
  int? isSale;
  int? userId;
  int? networkId;
  int? cardCategoryId;
  String? createdAt;
  String? updatedAt;
  CardCategory? cardCategory;

  CardTransactionModel(
      {this.id,
      this.cardNumber,
      this.isSale,
      this.userId,
      this.networkId,
      this.cardCategoryId,
      this.createdAt,
      this.updatedAt,
      this.cardCategory});

  CardTransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardNumber = json['card_number'];
    isSale = json['is_sale'];
    userId = json['user_id'];
    networkId = json['network_id'];
    cardCategoryId = json['card_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cardCategory = json['card_category'] != null
        ? new CardCategory.fromJson(json['card_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['card_number'] = this.cardNumber;
    data['is_sale'] = this.isSale;
    data['user_id'] = this.userId;
    data['network_id'] = this.networkId;
    data['card_category_id'] = this.cardCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.cardCategory != null) {
      data['card_category'] = this.cardCategory!.toJson();
    }
    return data;
  }
}

class CardCategory {
  int? id;
  String? category;
  int? price;
  String? hours;
  String? validity;
  String? link;
  int? userId;
  int? networkId;
  String? createdAt;
  String? updatedAt;

  CardCategory(
      {this.id,
      this.category,
      this.price,
      this.hours,
      this.validity,
      this.link,
      this.userId,
      this.networkId,
      this.createdAt,
      this.updatedAt});

  CardCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    price = json['price'];
    hours = json['hours'];
    validity = json['Validity'];
    link = json['link'];
    userId = json['user_id'];
    networkId = json['network_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['price'] = this.price;
    data['hours'] = this.hours;
    data['Validity'] = this.validity;
    data['link'] = this.link;
    data['user_id'] = this.userId;
    data['network_id'] = this.networkId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

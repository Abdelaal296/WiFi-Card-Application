class RegisterModel {
  bool? status;
  String? message;
  UserModel? data;

  RegisterModel.fromJSon(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? new UserModel.fromJSon(json['data']) : null);
  }
}

class UserModel {
  String? name;
  String? commercial_activity;
  String? phone;
  String? address;
  String? password;
  String? password_confirmation;
  String? distributor_account_number;

  UserModel.fromJSon(Map<String, dynamic> json) {
    name = json['full_name'];
    commercial_activity = json['commercial_activity'];
    phone = json['phone_number'];
    address = json['address'];
    phone = json['phone'];
    password = json['password'];
    password_confirmation = json['password_confirmation'];
    distributor_account_number = json['distributor_account_number'];
  }
}

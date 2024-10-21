class LoginModel {
  String? message;
  String? access_token;
  String? token_type;
  String? role_type;
  String? error;

  LoginModel.fromJSon(Map<String, dynamic> json) {
    message = json['message'];
    access_token = json['access_token'];
    token_type = json['token_type'];
    role_type = json['role_type'];
    error = json['error'];
  }
}

class LoginModel {
  String? userId;
  bool? isVerified;
  bool? isNewUser;
  String? accessToken;

  LoginModel({this.userId, this.isVerified, this.isNewUser, this.accessToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    isVerified = json['isVerified'];
    isNewUser = json['isNewUser'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = userId;
    data['isVerified'] = isVerified;
    data['isNewUser'] = isNewUser;
    data['accessToken'] = accessToken;
    return data;
  }
}

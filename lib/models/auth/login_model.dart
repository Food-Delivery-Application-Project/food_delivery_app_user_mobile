class LoginModel {
  String? sId;
  bool? isVerified;
  bool? isNewUser;
  String? accessToken;

  LoginModel({this.sId, this.isVerified, this.isNewUser, this.accessToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isVerified = json['isVerified'];
    isNewUser = json['isNewUser'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['isVerified'] = isVerified;
    data['isNewUser'] = isNewUser;
    data['accessToken'] = accessToken;
    return data;
  }
}
